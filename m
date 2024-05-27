Return-Path: <linux-kernel+bounces-190158-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 831308CFA5D
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 09:46:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 21A9A1F2189E
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 07:46:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D4982E403;
	Mon, 27 May 2024 07:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D4th8tOY"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DFDC22079
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 07:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716795974; cv=none; b=RyTs1pADI795rO/F4NH9inPKi3V9eYtqK5asJJR58y955HjowwL4XmFyDo7P3gsJKfIFOcGsTWI4LapcTx8cuM2ncbsOphdXBED4dAGfpANSJESX79gNBTXLsyJ7Zrk5DMZcFQ4k7mM8Tg4GiWqWbqytOnbQAZsspBhsmas6uW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716795974; c=relaxed/simple;
	bh=aeodVEm/mobivBVUfs7zTByURZGspcUcD0t+38/3HiA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L6g8wTdhS7A67PIzpR3cEdKIZymJCVNlX9zoSPbSrSxkqiR3lqi6r2UQhownSi8JQlY0sRKlhwKkp6g330fBzon8SqqfLXZVQvmXwbTpfXVRsaj7K8gfzwN5Tni5Sev71FeoZY/vHOhJaIfcQubNA5oQrEwis7uICUnnoRdVamE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=D4th8tOY; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716795971;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bJZhvxGXUT9T0zhT9Bm8NpxZXQt5bsEOd5lUm7XYqDs=;
	b=D4th8tOYxca4POK44wJzovxBFg0+1PjtrAIYUoL2cS1mlBbQ9AGcrTAec8J5XOxq3Xn4Yu
	Ry7ktMlZSKXRe0Yf76FevJir0XLGuyx2AlD0laWbPUEBFjtsoJG4KXXcCwQjGFUtCHibtw
	7UXjc9vl5lsQ683aTNy4D7o/qKp2MPg=
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-210-pG6Uh0zKOCibTA9_2azj6A-1; Mon, 27 May 2024 03:46:09 -0400
X-MC-Unique: pG6Uh0zKOCibTA9_2azj6A-1
Received: by mail-oi1-f200.google.com with SMTP id 5614622812f47-3d1c7b5c0beso233221b6e.2
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 00:46:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716795969; x=1717400769;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bJZhvxGXUT9T0zhT9Bm8NpxZXQt5bsEOd5lUm7XYqDs=;
        b=pFzEgUrNKQU3sO8SQNYTaQcy91/EclbzaoQKh9IOMqJO14qDsIpuhRF9OYTosdNDVg
         OBprir8B7X1c3q10feofcT2azZVGO3yrFcbKMuoFEc8x3dfu4m1Iy+9/KGxjQ6kvE2/t
         HyGuQyYzLzfn3dsh0uy//120sjuczi6OmCx27Yu4qsTTw3okW9LbS8NkW8dDQCsPxsyJ
         sinz6Oiz6WGLatlLl81dBKo2wnCLyYaRvZK5bh2vML46qkneOlvdGijOSol6AiSBYqcA
         pb1CYfFVNTGV4IEjaH0giywkyzZZ6bw92uSOTVTnFerUSXYKXW90jSm88yrfjheQ3Yqm
         nCPg==
X-Gm-Message-State: AOJu0YwEWXlhuWQZwH0A1J58vemDscS7uOBSSlYEh5zYtEiDrdA+vENn
	5qNSQN+Xk/5nQPcsLSC7JgaYjxLW7zDJ+2FSv9eK3n1M1LirqUcIfrFeWER/mwUrX7a3v+5fVFD
	FmUKosoG2YiH5+zp6UMyH7tSXDifkiJncFHrtDTAHa5+opwe6NlRWpAmljdudLA==
X-Received: by 2002:a54:4406:0:b0:3c9:92e9:4d4a with SMTP id 5614622812f47-3d1a5670ecdmr9892237b6e.20.1716795969040;
        Mon, 27 May 2024 00:46:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGAbbXjX6ChuOgo2M0rqauoFiJgYUcJvR4iwaf+zhT1Fnpb371QdsrqEKkfGi471XXPew2QNw==
X-Received: by 2002:a54:4406:0:b0:3c9:92e9:4d4a with SMTP id 5614622812f47-3d1a5670ecdmr9892221b6e.20.1716795968327;
        Mon, 27 May 2024 00:46:08 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f28:4600:d3a7:6c26:54cf:e01e? (p200300d82f284600d3a76c2654cfe01e.dip0.t-ipconnect.de. [2003:d8:2f28:4600:d3a7:6c26:54cf:e01e])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-43fb5db77f7sm27019831cf.78.2024.05.27.00.46.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 May 2024 00:46:07 -0700 (PDT)
Message-ID: <ed45ef68-cb73-4e16-8a16-2e2008fe873a@redhat.com>
Date: Mon, 27 May 2024 09:46:05 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arch/x86: Do not explicitly clear Reserved flag in
 free_pagetable
To: Oscar Salvador <osalvador@suse.de>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 Dave Hansen <dave.hansen@intel.com>
References: <20240527044523.29207-1-osalvador@suse.de>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
In-Reply-To: <20240527044523.29207-1-osalvador@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Am 27.05.24 um 06:45 schrieb Oscar Salvador:
> In free_pagetable() we use the non-atomic version for clearing the
> PageReserved bit from the page.
> free_pagetable() will either call free_reserved_page() or
> put_page_bootmem(), which will eventually end up calling
> free_serverd_page(), and in there we already clear the PageReserved flag.
> 
> Signed-off-by: Oscar Salvador <osalvador@suse.de>
> ---
> This has been like this since commit ae9aae9eda2d ("memory-hotplug: common APIs to
> support page tables hot-remove"), so I might be missing something obvious, but
> I cannot explain why we would need that __ClearPageReserved upfront, when
> free_reserved_pages() already does that for us.

Especially, we only call it on the first page (in case we'd have order>0).

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb



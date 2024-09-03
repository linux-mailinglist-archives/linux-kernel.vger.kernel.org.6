Return-Path: <linux-kernel+bounces-312417-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 374A796965F
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 10:00:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E387B280E1D
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 08:00:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF59115573A;
	Tue,  3 Sep 2024 08:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PbNnkSx7"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C04FB1CE6F5
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 08:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725350422; cv=none; b=Mw86NZd9x/fCHmgWaBEd5LLaCLO0E0QZb/Fh58sHhdN0f4Y3YRqLCHG7ryHZ5v3DKhMvZOu+pdrqFdY6k5lDWgTzaJoaYeLgfZT/8GuhJTOKD604elRzdCh7KzMQ37NfuuFyhsReKFJGI5hTdmCwGN9qtAlA2dvyvK6XZKAarw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725350422; c=relaxed/simple;
	bh=zyQxPE/v5DxRkE34ovXoMJvZ10hX/bAEWVi1APdK13Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Fi++IHlQT+JXqCUSJRQaAoB091EvoJ8JYjjPjkK0TO9TDpFaPHoaIhwa3YYCFBWtOOYggnnytl4eYuRcO8s71uDsp2PVLgJWfiIOD1HUVmLlM9J/TY1/yR4pLHLAHI6LKY9diWIkGhVRU64l9965eyoR7PI248zj1CodpFL9NtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PbNnkSx7; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725350419;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Zh4/w/TN6ZnzasjnUN7ph28XU3qMfhRtE0oxWkqePpQ=;
	b=PbNnkSx7OXrrsORVGh9MjnNYoO7EcIkiPYEOMNmGKzQPjjJ58rW5pB/cqT+6gOFi621tjH
	6wHlWBGvymfdXBhGwI6Yc5vDja+r6yr9l1Hogz7miDhww1ihQyui6afz//Ye3FOlYidcll
	VXGUnK/QjHc27akcLeUH0q5WMTaYGNk=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-280-OBE0LhdFNv6Dzrsy_1VOiw-1; Tue, 03 Sep 2024 04:00:17 -0400
X-MC-Unique: OBE0LhdFNv6Dzrsy_1VOiw-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-428ea5b1479so394905e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2024 01:00:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725350416; x=1725955216;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zh4/w/TN6ZnzasjnUN7ph28XU3qMfhRtE0oxWkqePpQ=;
        b=JLxPYF6qPXY+fiSYrMB4y5C1H+OlpDa+PKp8eDDTmUwoVgGBVn5VRdV906prEgfgPZ
         +4kpD7NQ8Mxd5Zt2b/kqf6XOsjf65u0Q4Su2tosmIqfodk3Es8M4Gl+dIkiEIvquEwCE
         dAAn3nip4/UknsikTRtJv2Bp/pDy/smDIQVkIMpDKcsgRo1YDw8xEgrTQGxLCrrYkTkm
         qLIyv8Mf+4id/E+Wvew5dtXfa3Wv/95qVNmUXcZonIzsdMxtI6v4n/FKcDe8aeOEapd9
         o8WwcGWrBRy13rF7kNuSRXYVGTNPcLVbU/kQSEimGe6TfmxBU/q1tS7TF23ai1e0Y1hh
         rsow==
X-Gm-Message-State: AOJu0YzuqcANyTfTcROjFocN6+zIv1wnZbMa5ioE7rfWebg0d6WhdNq9
	6Gnma9xZMQ49ZxP+Kzhrc1RPVePxIPRKfOd7d5bJuOT8L7pdVWgcmBHDC4dgx7pRs5u4lCE7L2F
	xcy8OvMz3mhZeGJf+cHf2180SJyYplff41vsBYKsMO3//xflnUFkcoYr/sUk9FA==
X-Received: by 2002:a05:600c:3549:b0:426:6379:3b4f with SMTP id 5b1f17b1804b1-42bb01fb8d4mr113244675e9.31.1725350416367;
        Tue, 03 Sep 2024 01:00:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHCBGwJoZHyWvw2AnQPHpl54ggjHTUbmuSSuNi9wGgLZVX53yWaS4NVVaX5X8/w755Ui6yQrw==
X-Received: by 2002:a05:600c:3549:b0:426:6379:3b4f with SMTP id 5b1f17b1804b1-42bb01fb8d4mr113244315e9.31.1725350415764;
        Tue, 03 Sep 2024 01:00:15 -0700 (PDT)
Received: from ?IPV6:2003:cb:c709:7f00:8a04:4c6f:a761:af60? (p200300cbc7097f008a044c6fa761af60.dip0.t-ipconnect.de. [2003:cb:c709:7f00:8a04:4c6f:a761:af60])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42bb6df0dbcsm162999235e9.17.2024.09.03.01.00.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Sep 2024 01:00:15 -0700 (PDT)
Message-ID: <fb4235f1-7ad7-443b-a802-7161f9613d21@redhat.com>
Date: Tue, 3 Sep 2024 10:00:14 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] mm/ksm: Support prctl controlling KSM with pid
To: xu xin <xu.xin.sc@gmail.com>
Cc: linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
 shr@devkernel.io, hughd@google.com
References: <20240901043525.1683177-1-xu.xin16@zte.com.cn>
 <20240903041314.1775342-1-xu.xin16@zte.com.cn>
Content-Language: en-US
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240903041314.1775342-1-xu.xin16@zte.com.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 03.09.24 06:13, xu xin wrote:
> Thanks for your reply.
> 
> Selection of interface
> ======================
> 
> At this point, I have been thinking for a long time, and in order to achieve
> the control of the KSM scanning of an already running process, the current
> prctl PR_SET_MEMORY_MERGE is the most suitable interface. On the one hand,
> it is compatible with the existing KSM PRCTL interface, making it easier
> for users to get used to and adapt to it; On the other hand, it adds prctl
> control over processes that have already been started through PID. Lastly,
> I referred to the PR_SCHED_CORE option of prctl, which also uses arg3 to
> perform operations on tasks pointed to by specific PID.
> 
> Anyway, the current way may not necessarily violates "prctl() manipulates
> various aspects of the behavior of the calling thread or process." ,
> becasue we can consider controlling KSM scanning of pid as a behavior of
> the calling thread.

No, it's just wrong. Find something else.

-- 
Cheers,

David / dhildenb



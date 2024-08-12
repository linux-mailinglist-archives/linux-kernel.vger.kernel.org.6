Return-Path: <linux-kernel+bounces-283369-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D46494F193
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 17:24:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CA5EEB23F82
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 15:24:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 553A8183CD9;
	Mon, 12 Aug 2024 15:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QT1gXLiP"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3300F17C22F
	for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 15:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723476287; cv=none; b=DUhw94cDFTupe6hVRlaHKnDJmuW2GuP1kJqgnUueyTZsXbhaidm2KbSmj6EmQwvnwNu9vGg5lx4EWog29X1M4EjYMMFvvbOQI0gm8lcgi08r5VQY6OOkpmUf66cXTHzqatMBeI6YbmibbkFAZndZb7aQU+LZIeNC0LX8k3ognNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723476287; c=relaxed/simple;
	bh=isci/s8Rp6k7733oXOuN/icyGOh/MDoaBbr8cppuWjE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S4U4qmQ/eZWgUsMVoCZ7RiF/9WWlNh/mo/dfoVIGjr8i/auneAhvbmeBz/mlNkUgIkIA5Z9XtpPxv6oz/58+do15su7QsUVocCNi09zIFw7nqkAmPQPLvOXbIMHtvVBRTZ6D6CyjOYOCzJBcygeK8FomX9oqplH4rLwZBwC8yMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QT1gXLiP; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723476285;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=O0G8nniO0W4Joc9T/59AnRTYYBY/vndqQxuJm8W02Kw=;
	b=QT1gXLiPCgv2EYJtHbeTH/KoD1iuKhXLK6rBs/lDBlaDq53ECoD7oFS9HEE3M9eK8q2vQ8
	5vfOzs+gnEj/DESRU4Cn6dQ/RTTIH7cHcxIxObYTkSkmkEACOig8NjT6i5v9MhOarCL0F9
	Z8fDA12LiytN9mIsyWLYTRPSpKio0ZM=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-686-i-T_c9tTM8G2csQ-xmXJGg-1; Mon, 12 Aug 2024 11:24:43 -0400
X-MC-Unique: i-T_c9tTM8G2csQ-xmXJGg-1
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4503ee1b5d6so6799501cf.3
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 08:24:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723476283; x=1724081083;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O0G8nniO0W4Joc9T/59AnRTYYBY/vndqQxuJm8W02Kw=;
        b=njsCAI7r44hONajQtoSx3OsB1gqOvYer5LiLJkW+XBbiWRcLCl24cW07IalLAt5E9u
         vrJvYf88L5x+85yOt4aitloONl+qpBkhegZEZ0sRiZwihBY0iQ7eHWzVt+S31a5hxbxN
         tEWpFJzzSlzjkumt7ujMRlgH7FSXK4ejKZNNHuViVpPVArH/Eo4zIV3YcuuwgTKzXRMa
         1xJhmgW9t0fthr+mf4/CC0SyIx497D3Gy13UiRuORZ8bQq0LerqCOdHBLzMyDGtQQTdH
         FlhPAVzNmY4c5tFVIqIzAjiU/YPjwuDRyfmkwetf+kIhq1qCqdqRnUr8KbWs+ABJ1jLJ
         NxDw==
X-Forwarded-Encrypted: i=1; AJvYcCUtuMhCfAX6m6kcjIAXlB0rfPbgffRXFuC7wzu/lNbT3XkFlgbyWxG9CyxMNCn1dat2XvrRLK5D7bwp6qSfNsS5y2c/rPuT0UTFofye
X-Gm-Message-State: AOJu0Yx4QeJeNZOe1fJTmcTQxCnVH9a0vx3c1iCISoiF/Zl6kEhQ/6n6
	8XJb+TdYueu8crRtSrPmTPXEf2dxY5cdIlYLmZDN3dM10AIA0wnPcBUo9LkRyIwzqhAb9ozWUPv
	Qg5oi5g7QcvnAgZskqfF4SCADkkQBJd4/qciss55s75sYsv2/NrwQs6UO4rSLuA==
X-Received: by 2002:a05:620a:3ece:b0:7a4:e206:a97d with SMTP id af79cd13be357-7a4e206a9e7mr18695885a.0.1723476283376;
        Mon, 12 Aug 2024 08:24:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGYTEAFfpLzjuAQHij27kFr73YainEyUsOtaltqhSvPe0FyPuHQH8ZXYdrcb2vH99sGj94uEQ==
X-Received: by 2002:a05:620a:3ece:b0:7a4:e206:a97d with SMTP id af79cd13be357-7a4e206a9e7mr18695485a.0.1723476283042;
        Mon, 12 Aug 2024 08:24:43 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com. [99.254.121.117])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a4c7d8b8e1sm254723985a.69.2024.08.12.08.24.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Aug 2024 08:24:42 -0700 (PDT)
Date: Mon, 12 Aug 2024 11:24:40 -0400
From: Peter Xu <peterx@redhat.com>
To: "Wang, Wei W" <wei.w.wang@intel.com>
Cc: Sean Christopherson <seanjc@google.com>,
	James Houghton <jthoughton@google.com>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Oliver Upton <oliver.upton@linux.dev>,
	Axel Rasmussen <axelrasmussen@google.com>,
	David Matlack <dmatlack@google.com>,
	Anish Moorthy <amoorthy@google.com>
Subject: Re: [ANNOUNCE] PUCK Agenda - 2024.08.07 - KVM userfault
 (guest_memfd/HugeTLB postcopy)
Message-ID: <ZropOA2IQqOP9_7X@x1n>
References: <20240801224349.25325-1-seanjc@google.com>
 <CADrL8HXVNcbcuu9qF3wtkccpW6_QEnXQ1ViWEceeS9QGdQUTiw@mail.gmail.com>
 <DS0PR11MB63733F7AEC9B2E80A52C33D4DCB92@DS0PR11MB6373.namprd11.prod.outlook.com>
 <CADrL8HWH3d2r12xWv+fYM5mfUnnavLBhHDhof0MwGKeroJHWHA@mail.gmail.com>
 <DS0PR11MB6373A1908092810E99F387F7DCBA2@DS0PR11MB6373.namprd11.prod.outlook.com>
 <ZrZoQZEfTffvVT75@google.com>
 <DS0PR11MB63734864431AD2783C229C57DC852@DS0PR11MB6373.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <DS0PR11MB63734864431AD2783C229C57DC852@DS0PR11MB6373.namprd11.prod.outlook.com>

On Mon, Aug 12, 2024 at 02:12:29PM +0000, Wang, Wei W wrote:
> In the example above, both UFFDIO_COPY and KVM_USERFAULT_COPY need to be
> invoked, e.g.:
> #1 invoke KVM_USERFAULT_COPY
> #2 invoke UFFDIO_COPY
> 
> This requires that UFFDIO_COPY does not conflict with KVM_USERFAULT_COPY. Current
> UFFDIO_COPY will fail (thus not waking up the threads on the waitq) when it fails to
> install the PTE into the page table (in the above example the PTE has already been
> installed into the page table by KVM_USERFAULT_COPY at #1).

Indeed, maybe we can fix that with an explicit UFFDIO_WAKE upon UFFDIO_COPY
failures iff -EEXIST (in this case, it should fall into "page cache exists"
category, even if pgtable can still be missing).

I assume OTOH a racy KVM_USERFAULT_COPY in whatever form doesn't need
anything but to kick the vcpu, irrelevant of whether the copy succeeded or
not.

Thanks,

-- 
Peter Xu



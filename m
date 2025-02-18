Return-Path: <linux-kernel+bounces-519721-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88897A3A109
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 16:23:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D928167161
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 15:23:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABBAC1990C7;
	Tue, 18 Feb 2025 15:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bBmbLvmr"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CA3C26B941
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 15:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739892178; cv=none; b=T6imWXAdJ8FnTlryJzMpp9J+V0jPzximifpasKBEmS0hxgo6Dl8fyxBcMYeBHyIFzrK9529p4D7eR0UOOeKvEZmJDVXW+9nkqGLAPpTVQI6dKfI8VtZiJrFGA0o6RWfgGwS+GmzhQJoBdTgCkWh1awAzZHrkZtj1CMcLjn9s8MM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739892178; c=relaxed/simple;
	bh=dRqns3tgs9LOzsvNykyA2wnDs4hZV04yHkHiuozwTo0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=NKN4C+aoj03sA2SywZ8EpghqBdfvrshHCItqFiPlbC+WSUU/SQ8icZZXyPfoTVgPm38rlVMioxoMB/nbIEe6cmQW0LSHX626rGMOFASRqUWtTk0OWbTowtoZScayjUPuCMBA4vXQnVSutsSzWSgQoOSEb+0D9m7Wg1iarckMxrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bBmbLvmr; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-221063a808dso59475205ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 07:22:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739892176; x=1740496976; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=A4rBn1loiHVRgqEEQSp4qIiIQysoefBUpVmMVONI/VM=;
        b=bBmbLvmrD97265On5Lpt5wPjTUlVv8Tnqf41bK7fBmHxacgA9JJarrnD00NEj3okig
         Ti+cAqFrIibuzEPEuC1OInlzjhtGlrUd4dCKw7EjXunauSACmvEGAcQkbk73SArVVzR2
         w0mFtKmR3AjrRTc4D7+y1Qy3dIKO5bEzoi6C0+0eu0k3yqKJqGAVGXM+SqPNLMsIfVhJ
         pU1a42hhdiQ/ULk9HmZdWXnwP5JTHMiRF3OLJ+4pfx+DuZf1vLDS42BH18kED9TDcQTL
         ooEFnGDZ4l8k9GfFZs2ghoymnwD/U2YlvEc2KsAGEt79AyIpgBXLWBV2P6wuUzZrBpHo
         nGUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739892176; x=1740496976;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=A4rBn1loiHVRgqEEQSp4qIiIQysoefBUpVmMVONI/VM=;
        b=BjeWAh8M3JZFoIOqbPTDceJjohfsTC8/ypjtOkFsGcBxH277n+hPXigvOWgAn8wM+V
         WF3Ef2TOmwA7Zcdz0JPVLA5b171kJA+1ptQIuh4XUntUO9GDHV6gANOIlslsfZaSglnF
         pC+q+UiVcqo5YTYVr3UyuK9MgsrabtvLHMXiklus7SvuIC7Yz4zHPrKY2Ek1bQ3f/fSR
         J/RA/bv3RVOjoAYj87jP/QdfsgzLbIjmpuj1RvWzNBxHFGkp9bSjGWklzol1x/647AJd
         hlCXShFW6yZoRDYkeC5B/L4OzriazNaE8mjYeY+1KPUkvd83zwlnnmgS3qFFqwnKdTTO
         YPdQ==
X-Forwarded-Encrypted: i=1; AJvYcCV+idnWvUONF+HXlX8QlOVEqIN7B7m8L6aYAPNksZhbdnbUucmPjk889rAEAd58IZxe4psOlxEyhTSNIAI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwUErO1G87J8wJBqHD+4RbLttZBpcN2/Fer3bBAv6X0TUQ+Q2a
	sooHjsCZ6p0yY3rqSMGXFI5qjsCAU6mUlC8PC1s+yzw5RV09w00WpGpxDo0GNuUeijrJtBVA0JA
	AJg==
X-Google-Smtp-Source: AGHT+IHtk8QhNUJ5IVao0gvIDKE2j52eZP0sIqAgCjZecx7PvM8TzFSmR+acBjaj46uiYVes4srTDuaJU+E=
X-Received: from pfbjt23.prod.google.com ([2002:a05:6a00:91d7:b0:730:8a7b:24e0])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:790b:b0:1ee:a914:1d64
 with SMTP id adf61e73a8af0-1eea9142045mr14137360637.28.1739892176009; Tue, 18
 Feb 2025 07:22:56 -0800 (PST)
Date: Tue, 18 Feb 2025 07:22:54 -0800
In-Reply-To: <469ee330-7736-4059-9e59-ec7b9a6d3c8b@suse.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250210063227.41125-1-shivankg@amd.com> <20250210063227.41125-3-shivankg@amd.com>
 <469ee330-7736-4059-9e59-ec7b9a6d3c8b@suse.cz>
Message-ID: <Z7Slzs_4jZ2qkPAi@google.com>
Subject: Re: [RFC PATCH v4 2/3] mm/mempolicy: export memory policy symbols
From: Sean Christopherson <seanjc@google.com>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Shivank Garg <shivankg@amd.com>, akpm@linux-foundation.org, willy@infradead.org, 
	pbonzini@redhat.com, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org, linux-coco@lists.linux.dev, 
	chao.gao@intel.com, ackerleytng@google.com, david@redhat.com, bharata@amd.com, 
	nikunj@amd.com, michael.day@amd.com, Neeraj.Upadhyay@amd.com, 
	thomas.lendacky@amd.com, michael.roth@amd.com
Content-Type: text/plain; charset="us-ascii"

On Mon, Feb 17, 2025, Vlastimil Babka wrote:
> On 2/10/25 07:32, Shivank Garg wrote:
> > Export memory policy related symbols needed by the KVM guest-memfd to
> > implement NUMA policy support.
> > 
> > These symbols are required to implement per-memory region NUMA policies
> > for guest memory, allowing VMMs to control guest memory placement across
> > NUMA nodes.
> > 
> > Signed-off-by: Shivank Garg <shivankg@amd.com>
> 
> I think we should use EXPORT_SYMBOL_GPL() these days.
> 
> Wasn't there also some way to limit the exports to KVM?

The infrastructure is still a WIP[1], though when that lands, I definitely plan
on tightening down the KVM-induced exports[2].

[1] https://lore.kernel.org/all/20241202145946.108093528@infradead.org
[2] https://lore.kernel.org/all/ZzJOoFFPjrzYzKir@google.com


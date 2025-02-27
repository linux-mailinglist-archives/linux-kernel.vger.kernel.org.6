Return-Path: <linux-kernel+bounces-536853-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B5168A484D1
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 17:25:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 288F57A3A1E
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 16:24:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20D071B041C;
	Thu, 27 Feb 2025 16:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TnK/iiXI"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBF681AF0C5
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 16:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740673509; cv=none; b=g0fGeS4woKDLVjHU/jkpt8SJ/ybBuDqfXm1HpqVBCpOV88HdJLVOxJSyeKX89ViDdT1RL1adDVTuFB9vcr7s+tNNLnFrnPD09ycV9WJdhBAzlpKpZzu5ABmLwydcojK05HjvvwU1nFq8BSy8VTbvLXRDZwPLx0j4RtgLYhVHwFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740673509; c=relaxed/simple;
	bh=Ri1MyuTQ3DfaiKRBhOCLNshu3db3ZjBLJiL2b3GtGdM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Yu9pFLSojPH9Ig1QS+76dI0xFrXvs++UEU8A19TF7iNb6hlJPC1VXF740ottS2ZObbHINARgidb/GEpI4PrdWyGDnMnMwRvrnmmn+fEPVUy781SfZaeShHvgsBhsN/pNbhwp6DY2XscKxN1dj8+3aIOg+Ltp3vO7ymngNGaoT2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TnK/iiXI; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740673506;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ri1MyuTQ3DfaiKRBhOCLNshu3db3ZjBLJiL2b3GtGdM=;
	b=TnK/iiXI/VkqJQ3wP5I8fI5gE7iLdjHOHXHc1kbNx8xWOnOL4SlYCNajEyShKfiSaPYcUL
	du15dqsAeGjXWf251Lqxzo1umIcqn9horvamYX2PPoY61TQODNk/olV9y/E+Ol05MAZ+Ro
	w+nrEjRz1KvhKK9iIxRULD/62mMvpxE=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-682-m2oa1GIWNxWtFjNA8lQOnA-1; Thu, 27 Feb 2025 11:25:05 -0500
X-MC-Unique: m2oa1GIWNxWtFjNA8lQOnA-1
X-Mimecast-MFC-AGG-ID: m2oa1GIWNxWtFjNA8lQOnA_1740673504
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-38f455a8e43so476642f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 08:25:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740673504; x=1741278304;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ri1MyuTQ3DfaiKRBhOCLNshu3db3ZjBLJiL2b3GtGdM=;
        b=LxUKwRFpJQDBgcK3hoztn8MNfc0sXRxxJShyjL8ChsNMrbuHn2lKo+ozquYX3+U64n
         UiqcI8TKw2gr9tN9Whz3jvtpk+dWvQwkEnIGtj3q5HCp0fDi3OJpQ1G8E42IOQcQDcrn
         89y2iNkkVfbxBw/XlfL4SV5TEyDCKaGhsN6w8kBjCJVKBQc8y/AoyDRZuLY7oCleQspz
         wM7lygjCtfJeQI4ZDrxZHCpuJn/4BK9Ac2S0N140O3Bl/MWDphFlBMJHGIWGZWsPhxla
         aZwVhgeLZLkNr7weT3GgR8hnhCfmBtg2r+EoukNu2PyUepPTUKC3179TTZasuOrLSSay
         1CCw==
X-Forwarded-Encrypted: i=1; AJvYcCXcUbrVZrh7VSGIGIjtmdv/3HVdm0/DpXwM9MvlIDgBt8Pk0Mz8wDdJE84Hh+2A8p0z7HxjuDgklXczPcs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxxmLQmbBk4XOw+RhiCvroPGZWtQ9Dp/Hro31Y2dpaxE/tNMrN
	EBYlGmr0tgURvhctRU66m1VPsX+b8GN5+pT0Pb8UylQsxw0GjSuViF7/kk9a0ryhwzY6jXTSVSV
	lybefA5egy6RrQre4Q+j7lfyIxE/lRPVAgm5aMO73t/UNqTcCcm3qXr3XaJacaQ==
X-Gm-Gg: ASbGncsywDtSqRrzBaUFELC0yMNc0rRASJd4nPucBEtJY6CyJtATGhO5IdKiEx4lOCt
	Af7opfBoWYQ4EjWhhMJAxva+ASKPIvbJq4QnZQ12bfuFCUCRf2r6+xoloeax+tk4sKYvxXjJL8c
	C2AThudBcntaiyIMjmSRAvEjlSAWJ1yGzsmM/QKuguS5OyzviNwu8q5kN3tLFEzR1ZLGKNNOuTK
	2pr3xIChD+2gyOW3/sVTe0heFLS+iy67l2ltJv7DnSCV4Z4XKAjJvLOUOsBo6Uw3+EK0ixsvTyW
	WwPDaeKOhFgrfrb8j+oW9VvPk82Y0o+QaLmhQZ+TcM+DBN+t0SrCfvFUcvlxEdctIWi6VVdfU9Q
	1
X-Received: by 2002:a5d:6482:0:b0:390:dfa1:346a with SMTP id ffacd0b85a97d-390dfa13960mr3751689f8f.41.1740673504216;
        Thu, 27 Feb 2025 08:25:04 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHxESr78TbMiCJc78B+S3FCZt1TeKhyRBdF/5vrBhxbgnzX5veCrQujD/Q5E34H3rp9Z12miQ==
X-Received: by 2002:a5d:6482:0:b0:390:dfa1:346a with SMTP id ffacd0b85a97d-390dfa13960mr3751667f8f.41.1740673503912;
        Thu, 27 Feb 2025 08:25:03 -0800 (PST)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (213-44-141-166.abo.bbox.fr. [213.44.141.166])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e4844c0dsm2445478f8f.80.2025.02.27.08.25.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 08:25:03 -0800 (PST)
From: Valentin Schneider <vschneid@redhat.com>
To: Frederic Weisbecker <frederic@kernel.org>, LKML
 <linux-kernel@vger.kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>, Peter Zijlstra
 <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Marcelo Tosatti
 <mtosatti@redhat.com>, Vlastimil Babka <vbabka@suse.cz>, Andrew Morton
 <akpm@linux-foundation.org>, Michal Hocko <mhocko@kernel.org>, Thomas
 Gleixner <tglx@linutronix.de>, Oleg Nesterov <oleg@redhat.com>,
 linux-mm@kvack.org
Subject: Re: [PATCH 1/6 v2] task_work: Provide means to check if a work is
 queued
In-Reply-To: <20250209223005.11519-2-frederic@kernel.org>
References: <20250209223005.11519-1-frederic@kernel.org>
 <20250209223005.11519-2-frederic@kernel.org>
Date: Thu, 27 Feb 2025 17:25:02 +0100
Message-ID: <xhsmha5a7l5i9.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 09/02/25 23:29, Frederic Weisbecker wrote:
> Some task work users implement their own ways to know if a callback is
> already queued on the current task while fiddling with the callback
> head internals.
>
> Provide instead a consolidated API to serve this very purpose.
>

Ditto on Oleg's comment, otherwise:

Reviewed-by: Valentin Schneider <vschneid@redhat.com>



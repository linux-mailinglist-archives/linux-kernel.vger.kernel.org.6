Return-Path: <linux-kernel+bounces-544726-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C80C8A4E424
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 16:49:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 90C457A43BE
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 15:48:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2EB127BF75;
	Tue,  4 Mar 2025 15:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FbK87N6x"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A525427BF6C
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 15:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741102412; cv=none; b=I29XJBrqyav/BnoJBsF+SDwV9hlGqPp3IyfmTLRUx6vY9sK40eNJQ/z1mLl1NkZmoqvNVlCAyUWfTKWu/d9ivTs/tWLRzfdXDDb4wFEi0DuB3O+n2jW0hPckSsXn1DkI6L8bdkm3JWcDCy+XlwIzlbiHZbRpHRb9dT9FQisdW9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741102412; c=relaxed/simple;
	bh=AtmrxciAUjDUt8Le2C3RdTGI6SD4SxyI8sKwNOJLZCA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EPimT+jw0H00aB8pkgfXrmQRRUN2rQ7C+l6/lmPVexhzUm/1jlQflHNS8l5NaXivcZSxbbOQ4C8pWWkt5aHUbf0mISBTHrn5bw5QLj0GOrkhP8E4cSfUn9MetzNldM7JPl31eN0OYHKEcMLrnrRDLFuSP/yI9aTA5iWXjwu5iZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FbK87N6x; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-43ba8a87643so65205e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Mar 2025 07:33:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741102409; x=1741707209; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ibbQ8vZKRLThagAhXqw0zr6eU9i/rMMEX0Q2/bXISBY=;
        b=FbK87N6xjAqFW2IiTX2V+fTHzlw6YrXcomH/2te7OVH1AaaVbzgVEGy3eOvOfbI9bv
         HvzbAoh1KnFglcFFYwGz68dKVyto/NKRTtSG8c2Ca95LV+WfzifoyxaPb00cIXdaMv8q
         daA5Sp+jdEIN5qCyI89X91tT0Wgt/cJUBL9wBZd9NDmQ/iHan7OmZ2GagR1s04hUNADO
         vgHWZz5WKOLWNUKBxyPZ6Veakb3yyH46/OG2xXTjMchg3SJ19Rwv2pGg6t/cYJgwMviT
         BSJFT1KXdwjx1asPVGBjh8p2WGY2AJ/PXCjIHVkszuKzhXnb4wMQGA5EYKMArVjr+0dT
         XiHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741102409; x=1741707209;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ibbQ8vZKRLThagAhXqw0zr6eU9i/rMMEX0Q2/bXISBY=;
        b=Ic5dKvHSqKA6yl7BsXvHP9BSXo/D4GIOpH4W6bBqjy9lOAZeSX2FQ8KM4Ym+IPCWpB
         yTlkUcdprH3eE8rFqKU5fMc2lk24w/j7Yz+ZiD7CTu9ZfyOE6NLCLs2AqBRv7Qxb1alL
         P/goM//Bqo1eMoucaHhuJsQMcZreUv9ENyfxl89OwgUk+EC89RlqiEjuG8HVSMS2/9i+
         7eQmFGi0rlD0uuXyTDREVJT5W5ImywMN590KvTGigCaujgFOShNYxW37FHix9avwjili
         DcAUJnC8dpNaGl2VxSR2JzaLrJlrrf8wSr0ZnCbL9oqnhJcymqvNLVKDaThzPdPG4NkY
         va5Q==
X-Forwarded-Encrypted: i=1; AJvYcCVvnkofAsPxzZhieLt48JtKqAL9KRwiWthdDcldHuUdw4/yug8FpfLkJsT9vzR4UjrAtR9co32pryOt0G4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEoqNLeuUdhjXqcOW9Ush+j+ZQNp+R89sT9n3h42w8YdbOW3Wi
	td0WiDxBdr3rMvyThr8rAg0yOuvI3aiEJg2bXsveM2FjbrAnGZKuHNYIyKKgCA==
X-Gm-Gg: ASbGncsAD03RthsbHOra4HyZCMozkm8lOR/GiUIBsj+wYw5RXvg+K7qkIiehVUGcI+0
	5KZpGr4VkYhAfVPEZnXAO6dRpShcgPI585HUQIT8NmzhPzaNl0KtakFVh/liT1pOvSxBy9CcSVR
	CFW8vsnfq1ZGKatqaXyBmwvQNN3GggquNJgPJqbY5Jay0Q4zIi0wXF255Yt5gvxig+iFEE4KgWe
	g5L7q135nHqggEbsZYKlnlNm60fgeBmTUeog2P7neI7zKfiukugxYhHG3Jwuk3muXZ3P6h8WJY/
	9dvi2GmIgW1h7T3L/al6PrVCfXgRSn16HdilbdyHmrno1rZyk9HdyVZ3eu9SXT/6+Ti00x8keiA
	ljs9m
X-Google-Smtp-Source: AGHT+IHD6tgroZwF1RiEywTFB8Xo582z8MBUAfqrce6J1GbfQJzHVOeJsLd40g5y/9Wkv4MuwqP+ZQ==
X-Received: by 2002:a05:600c:3593:b0:439:8f59:2c56 with SMTP id 5b1f17b1804b1-43bcb43acc4mr1414045e9.2.1741102408761;
        Tue, 04 Mar 2025 07:33:28 -0800 (PST)
Received: from google.com (44.232.78.34.bc.googleusercontent.com. [34.78.232.44])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43bc993abc5sm45371435e9.2.2025.03.04.07.33.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 07:33:27 -0800 (PST)
Date: Tue, 4 Mar 2025 15:33:23 +0000
From: Brendan Jackman <jackmanb@google.com>
To: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@intel.com>, Rik van Riel <riel@surriel.com>,
	x86@kernel.org, linux-kernel@vger.kernel.org, peterz@infradead.org,
	dave.hansen@linux.intel.com, zhengqi.arch@bytedance.com,
	nadav.amit@gmail.com, thomas.lendacky@amd.com, kernel-team@meta.com,
	linux-mm@kvack.org, akpm@linux-foundation.org, jannh@google.com,
	mhklinux@outlook.com, andrew.cooper3@citrix.com,
	Manali.Shukla@amd.com, mingo@kernel.org
Subject: Re: [PATCH v14 11/13] x86/mm: do targeted broadcast flushing from
 tlbbatch code
Message-ID: <Z8cdQwVnx8dmFDLA@google.com>
References: <20250226030129.530345-1-riel@surriel.com>
 <20250226030129.530345-12-riel@surriel.com>
 <20250303114618.GBZ8WWihMDjf-oy8P0@fat_crate.local>
 <7e1ca8c7-6f3e-44dc-9dd8-bd273a03a83e@intel.com>
 <Z8b3n85dpkz_-2ci@google.com>
 <20250304141134.GIZ8cKFom3W0ChHiXk@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250304141134.GIZ8cKFom3W0ChHiXk@fat_crate.local>

On Tue, Mar 04, 2025 at 03:11:34PM +0100, Borislav Petkov wrote:
> On Tue, Mar 04, 2025 at 12:52:47PM +0000, Brendan Jackman wrote:
> > https://lore.kernel.org/all/CA+i-1C31TrceZiizC_tng_cc-zcvKsfXLAZD_XDftXnp9B2Tdw@mail.gmail.com/
> 
> Lemme try to understand what you're suggesting on that subthread:
> 
> > static inline void arch_start_context_switch(struct task_struct *prev)
> > {
> >     arch_paravirt_start_context_switch(prev);
> >     tlb_start_context_switch(prev);
> > }
> 
> This kinda makes sense to me...

Yeah so basically my concern here is that we are doing something
that's about context switching, but we're doing it in mm-switching
code, entangling an assumption that "context_switch() must either call
this function or that function". Whereas if we just call it explicitly
from context_switch() it will be much clearer.

> > Now I think about it... if we always tlbsync() before a context switch, is the
> > cant_migrate() above actually required? I think with that, even if we migrated
> > in the middle of e.g.  broadcast_kernel_range_flush(), we'd be fine? (At
> > least, from the specific perspective of the invplgb code, presumably having
> > preemption on there would break things horribly in other ways).
> 
> I think we still need it because you need to TLBSYNC on the same CPU you've
> issued the INVLPGB and actually, you want all TLBs to have been synched
> system-wide.
> 
> Or am I misunderstanding it?

Er, I might be exposing my own ignorance here. I was thinking that you
always go through context_switch() before you get migrated, but I
might not understand hwo migration happens.


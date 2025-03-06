Return-Path: <linux-kernel+bounces-549073-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 71C6BA54CDE
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 15:04:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1626D188A444
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 14:04:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EECA7155757;
	Thu,  6 Mar 2025 14:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RnsN0hbl"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E9511547F3
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 14:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741269879; cv=none; b=VR922ErckhSb6cSswnmLYEO8ourDqNI5i5Jhvj90KuNORpLZWUZT0oCeCyc/Cd0NTUTxF7CgAg9J9xSBL5Yri4sMwNXs1fo2z5z5ikuqPqr2sx9bpAbzcKFqPTx/5tQzt4jdtq1bkuUK2BjK+YSHODoNMp2T3OP6ctEFqdd9WEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741269879; c=relaxed/simple;
	bh=R8Sm3svdW/goUTU5rLDpziJHP2XsdLH8VJwkfv4HNAo=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DEUiGlA9BszusYawAqmNHJd2HI2nNXEbAlx6llyixqETOt1ob9SRPwwo9W+HLNkM0R5wzXTaft16Z/3BJBcESgU3i9kUPNOP6czp7eQ6cG0jrwtPQy2gDl224vvrnTilnOE2gxflzaUPTboY/eUaLBkzD5rl+7PzSXfKxxenjy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RnsN0hbl; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-54298ec925bso1043568e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Mar 2025 06:04:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741269875; x=1741874675; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9w1loW1D93ByGjxUH+v0w87cRUrgY5imRrAfL3a+uhQ=;
        b=RnsN0hbl1C4SdiIVzDA4O/tC67+3S3ayKzN6yQVL83K4AAe52gCt3MJgEku2y0H3PF
         uLWz7Rlnie5Uq81LMZ+JYZpisVmR7Wg38QdAHRBq8wGn2XggNQ/uHt95EQQCFfX864bU
         FKpyisFEh9IgWckzxiUO1zNvjmOdT40tUs8wUEWPHLVGz7xfmdLnqiq6vN8m1cE+ozeC
         afFRT9oJTjvgWHjmp9xmnQLgLShHAtrfDqUsjryoW7zpU7zI5aqz5tpaYrBQ1iMBqSFm
         cR6p+77U5+9kBNa2Gd/Bme6IS80z/H8Si7dVY0FgOMeAUP16ehNob2yzKtKLpduEnoNP
         9Hnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741269875; x=1741874675;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9w1loW1D93ByGjxUH+v0w87cRUrgY5imRrAfL3a+uhQ=;
        b=XmakIZ+yd6WF3Hy7gPfEQ1PuebkqWmt2k5RRoxmiLdTNdxAWq8NJNMgJHGV9qL8xPB
         tMeoE6YxbsvNcJGyAHLUXD/RPLaSlbVj/28vRS2rM85x7TzdgLUbMQ4+s9VSbu0Lx3XX
         re7exisp0wOBQKaoXo7953UV/Za/hwItpL/vtm3bgvswhod5C6AetrI5HsBlndCLHhf4
         LDLOaGRH6Eqzwge0QzwuZDmX2OwkQ4z/b/SLm9GpGhZMV4Trga4BxyDlPLRlDdLmOdit
         DATeNZUVrPomFUNfMPMuJ8wck1XgZCxah6jv7xBEtJJvE+zckV3NkTomrsdqcSHVtl2i
         w/Kg==
X-Forwarded-Encrypted: i=1; AJvYcCXZfgQX7pqZVYYTgTWPsA5vmG/ekWF1jw33/P4kwtTuw2lfFjFmxUpYJ6lykzL1vAgJ3E2gDg86nwG+1rU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUxeBwOE4lfSkyvEAd/9Ei2WK351iV1t9T4A7iteIYjgbPkNdj
	ZI5bFo38fkjasSPxKFnhHub8NVXn7WLdgT14g+k3ON3ZVY4SyH4z
X-Gm-Gg: ASbGnctKkUpqLBrKp13wp8ltWTLcUqGK820834rJg861HXVyzy4l/9NgaDwjKY+tvKJ
	EZfn0Bef7Qv/Qwn/GhzSxFgpAjkPvhn85RH2XtdiPlfjk1WdNSfe0adl/0RLVAXlMvx6oaSME02
	RPyUi+d9G8r6zUN527T/BAr3w3qv7GlU8xa47Lo+IL1w3Rj/r8OtLApvZlzR4LgaROA4cLVVQgN
	QzEohNE1Bb7zuEZJ8qFvNKnfU9vco/7rSkrg596UZw1YaI23AHIVajkRq/L0dAAgZHz6gTl45My
	IsEwW+yRxoajFmtQKZ1y+sHAEoI0STUcXSJN9gtE/a7RkD+Q/VCZiqVEgLTq5gpHAdY=
X-Google-Smtp-Source: AGHT+IGonnW2BIlqC2FdXER3bXAFv4ISuWErmmFhIv+nnElrcZtI1jJxe9rCZw7FGgE21qslHhMlvg==
X-Received: by 2002:a05:6512:281d:b0:549:5b54:2c66 with SMTP id 2adb3069b0e04-5497d345ea7mr2751359e87.23.1741269875014;
        Thu, 06 Mar 2025 06:04:35 -0800 (PST)
Received: from pc636 (host-95-203-6-24.mobileonline.telia.com. [95.203.6.24])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5498b0bcf82sm185064e87.154.2025.03.06.06.04.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 06:04:34 -0800 (PST)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Thu, 6 Mar 2025 15:04:31 +0100
To: Jocelyn Falempe <jfalempe@redhat.com>,
	Matthew Wilcox <willy@infradead.org>
Cc: Matthew Wilcox <willy@infradead.org>,
	Ryosuke Yasuoka <ryasuoka@redhat.com>,
	maarten.lankhorst@linux.intel.com, mripard@kernel.org,
	tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch,
	kraxel@redhat.com, gurchetansingh@chromium.org, olvaffe@gmail.com,
	akpm@linux-foundation.org, urezki@gmail.com, hch@infradead.org,
	dmitry.osipenko@collabora.com, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org, virtualization@lists.linux.dev,
	linux-mm@kvack.org
Subject: Re: [PATCH drm-next 1/2] vmalloc: Add atomic_vmap
Message-ID: <Z8mrb_zcou6Hn7hF@pc636>
References: <20250305152555.318159-1-ryasuoka@redhat.com>
 <20250305152555.318159-2-ryasuoka@redhat.com>
 <Z8kp9Z9VgTpQmV9d@casper.infradead.org>
 <3bfd4238-6954-41a3-a5a3-8515a3ac9dce@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3bfd4238-6954-41a3-a5a3-8515a3ac9dce@redhat.com>

On Thu, Mar 06, 2025 at 02:24:51PM +0100, Jocelyn Falempe wrote:
> On 06/03/2025 05:52, Matthew Wilcox wrote:
> > On Thu, Mar 06, 2025 at 12:25:53AM +0900, Ryosuke Yasuoka wrote:
> > > Some drivers can use vmap in drm_panic, however, vmap is sleepable and
> > > takes locks. Since drm_panic will vmap in panic handler, atomic_vmap
> > > requests pages with GFP_ATOMIC and maps KVA without locks and sleep.
> > 
> > In addition to the implicit GFP_KERNEL allocations Vlad mentioned, how
> > is this supposed to work?
> > 
> > > +	vn = addr_to_node(va->va_start);
> > > +
> > > +	insert_vmap_area(va, &vn->busy.root, &vn->busy.head);
> > 
> > If someone else is holding the vn->busy.lock because they're modifying the
> > busy tree, you'll corrupt the tree.  You can't just say "I can't take a
> > lock here, so I won't bother".  You need to figure out how to do something
> > safe without taking the lock.  For example, you could preallocate the
> > page tables and reserve a vmap area when the driver loads that would
> > then be usable for the panic situation.  I don't know that we have APIs
> > to let you do that today, but it's something that could be added.
> > 
> Regarding the lock, it should be possible to use the trylock() variant, and
> fail if the lock is already taken. (In the panic handler, only 1 CPU remain
> active, so it's unlikely the lock would be released anyway).
> 
> If we need to pre-allocate the page table and reserve the vmap area, maybe
> it would be easier to just always vmap() the primary framebuffer, so it can
> be used in the panic handler?
> 
We can reserve a vmap space for ATOMIC or NOWAIT allocations. As for PTE
part, we can also populate reserved space, because after that operation
those are never get released.

The question is how many users need this. As for this particular case i
am in line with Jocelyn Falempe. Allocate for DRM and write on panic.

--
Uladzislau Rezki


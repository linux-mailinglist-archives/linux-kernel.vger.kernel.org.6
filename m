Return-Path: <linux-kernel+bounces-218393-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C69AA90BF24
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 00:43:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD3A41C21B36
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 22:43:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76B6819938C;
	Mon, 17 Jun 2024 22:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xg2CusN0"
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E29ED1D953B
	for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 22:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718664201; cv=none; b=iXa84sBURQdODvy5RVhyb4EOBECyoobmsbRr14d2zRAnWDx7qoPUHkNl5s1VJJKGgcSzKSUw0C2clla3293A+mDIv02bn/A7w3o7To1Cp1QT3PzvHnt7+9vOR9o1/F3qvsNHfUTZs/4sMI5JKoN93/MnV01XtRAxu8ES+sS1GsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718664201; c=relaxed/simple;
	bh=z7v43z4JwJ+bx01sFEZLbfa4sD9A6Q/GikXlekOd5WQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UCVAeJuPLVmXpDHM0wrrYcl4mHUGH2FVJ87WNG/Dopt/IhwP7hajJVqSrTjyKcWiq7cF6F9acJgjlTAQKojdz7Gng7FT3VULLbQiIv0KDuuCdqF7up1acXw7SciIli0tODboXoiUb4dpCOfgrYJRSozT6TOzWfcocxfDjBkiseY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xg2CusN0; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-7955ddc6516so346683685a.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 15:43:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718664199; x=1719268999; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GeO3b9/JgR7nK+A2tGDKNcAdjkJdiJOYwWoaO4SErgs=;
        b=Xg2CusN0HNsm7F49N98hLqIG8sjm0wwIRi3IAR/fQ1rbKew1U9KijyRkzd+Q1jR/Pu
         R5LhDSH8UVKzmhT7jFlvVSD8b8C6kPsSBh+VgZKRUNUtEGKIjEBUq6ssQqxkSvv5Qpau
         oQubO1RrUtur+YP+UVSgQ2J6b6XavJFzXovk8edbmZtutT2Xn/VHyP/gWNA32Pscrzev
         /EeWxodlyBvT/KcQM6z067KcGC1aKP5Y0TiGHr4QFHLFIb8IiLfHSq2KoTMEV0bDoRSx
         qs1ICrSV0ony+dX8fDRcdDjjeZ6Q9LfW9+Tf75nDvYsalSE/h1ccwBgGhvlqKlwFweF+
         3vPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718664199; x=1719268999;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GeO3b9/JgR7nK+A2tGDKNcAdjkJdiJOYwWoaO4SErgs=;
        b=pQAKiItpaervB49EI1cBgURkh3PNu+EX8QkV2Lk+fE5XQF8hCPmHlg7x1LLhpYv1SF
         C17bKwBF3rMC9+8lBEU/GoraGWHHlKU4HiUyjpEuWXgXw/fg4q03Sm3/LevXEpVKZkB3
         np/kJXlXdiho/6W6eFi0ruthBySe0V9mTQPksjZDAvmnfqMW9EV3HFh2uh1gPtNkJy+J
         YOSk0oOQmDUS/8bes5K6zJFE2GVEd3iN7u3Owm6ERFq87oey6NDBQ4rad7JKMxgM4sYo
         VS/r7cW416Xm0QRK/T9hRgXaohrFVlNiZWQVUYu2MnP3OETKY1Wx8QztMJAcb0H+4rDX
         VC9Q==
X-Forwarded-Encrypted: i=1; AJvYcCX8p73+x5GfG2huM7LIBwAHO5i6Szm1bFXpAou7C0nx/1ueOK5rkZSuf3cYFkzAyJrhdvqAsd2KRhYUuhcvguCZR4G2ZA+ddgSgBGTl
X-Gm-Message-State: AOJu0Yzl5mWk29uRg3tdDbAbutZgO9P6xLFfQRQ6gq7DMTVw73uVNnqM
	WnK84qNllyXSPsZNfFUp7RTFYtkuVfd/2sJ53R+jD2nwgwk1ECko
X-Google-Smtp-Source: AGHT+IEvIdR50paoQxiEzAxCR6CfH5HmzflOrBe7KJRFIVKRDeVUauhIos/1Xbck4FmUNbH9sbT9mg==
X-Received: by 2002:a05:620a:410b:b0:795:56de:38f with SMTP id af79cd13be357-798d23e6d18mr1391574785a.1.1718664198869;
        Mon, 17 Jun 2024 15:43:18 -0700 (PDT)
Received: from fauth2-smtp.messagingengine.com (fauth2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-798abe4ef86sm469030985a.121.2024.06.17.15.43.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jun 2024 15:43:17 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfauth.nyi.internal (Postfix) with ESMTP id 4D5881200068;
	Mon, 17 Jun 2024 18:43:17 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Mon, 17 Jun 2024 18:43:17 -0400
X-ME-Sender: <xms:BbxwZhrSUkPdnV1TSe6ekMnBr_SYp8PFNeeshzTl1TtzW5WNpktWMg>
    <xme:BbxwZjrt9JZppdxAc7PN5-gnROsBHfRpfD87Pr9KUCtyLS6jDNePv-4MaSCXUGRYg
    fylr06NCXS52kvVMg>
X-ME-Received: <xmr:BbxwZuN1Q0hVl1o3GJ35vll24wNPR2BO6sjpVlMOv3Mhhbcn6YdH7v-zUUw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfedviedgudefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhu
    nhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrg
    htthgvrhhnpeehudfgudffffetuedtvdehueevledvhfelleeivedtgeeuhfegueeviedu
    ffeivdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    gsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdei
    gedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfih
    igmhgvrdhnrghmvg
X-ME-Proxy: <xmx:BbxwZs6Pyiy9ikca8-0KwhbGiWcUMRMKf_N7d-G7nDDOO4vzYP-R6g>
    <xmx:BbxwZg4TnoFh_SRLCwfUVqAtMi0Rwkj41fmu0hrsx4c2y__txQpU-A>
    <xmx:BbxwZkhNO2uVhiI759KczF8oOOWp1nMfinjqhNO-QSsWEfVvHcELhQ>
    <xmx:BbxwZi4prBB_Gr2F2ls1Aye2JrOzUMeHYLKqHKTSZ-1DUHRGTdnqig>
    <xmx:BbxwZnKpZam7syydRpBRjqBwjTfKbHN4FFLK8c5_3qkvFscztyfEqkFv>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 17 Jun 2024 18:43:16 -0400 (EDT)
Date: Mon, 17 Jun 2024 15:43:03 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
Cc: paulmck@kernel.org, stern@rowland.harvard.edu, parri.andrea@gmail.com,
	will@kernel.org, peterz@infradead.org, npiggin@gmail.com,
	dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
	akiyks@gmail.com, dlustig@nvidia.com, joel@joelfernandes.org,
	urezki@gmail.com, quic_neeraju@quicinc.com, frederic@kernel.org,
	linux-kernel@vger.kernel.org, Viktor Vafeiadis <viktor@mpi-sws.org>
Subject: Re: [PATCHv2 3/4] tools/memory-model: Define effect of Mb tags on
 RMWs in tools/...
Message-ID: <ZnC79zgNZsWTSdVQ@boqun-archlinux>
References: <20240604152922.495908-1-jonas.oberhauser@huaweicloud.com>
 <20240604160440.498332-1-jonas.oberhauser@huaweicloud.com>
 <Zl_pehpjHVt2z95p@Boquns-Mac-mini.home>
 <5be2fcc0-0fd7-49d8-bc4b-12bf3e90a677@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5be2fcc0-0fd7-49d8-bc4b-12bf3e90a677@huaweicloud.com>

On Wed, Jun 05, 2024 at 09:56:31PM +0200, Jonas Oberhauser wrote:
> 
> 
> Am 6/5/2024 um 6:28 AM schrieb Boqun Feng:
> > On Tue, Jun 04, 2024 at 06:04:40PM +0200, Jonas Oberhauser wrote:
> > > Herd7 transforms successful RMW with Mb tags by inserting smp_mb() fences
> > > around them. We emulate this by considering imaginary po-edges before the
> > > RMW read and before the RMW write, and extending the smp_mb() ordering
> > > rule, which currently only applies to real po edges that would be found
> > > around a really inserted smp_mb(), also to cases of the only imagined po
> > > edges.
> > > 
> > > Reported-by: Viktor Vafeiadis <viktor@mpi-sws.org>
> > > Suggested-by: Alan Stern <stern@rowland.harvard.edu>
> > > Signed-off-by: Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
> > > ---
> > >   tools/memory-model/linux-kernel.cat | 10 ++++++++++
> > >   1 file changed, 10 insertions(+)
> > > 
> > > diff --git a/tools/memory-model/linux-kernel.cat b/tools/memory-model/linux-kernel.cat
> > > index adf3c4f41229..d7e7bf13c831 100644
> > > --- a/tools/memory-model/linux-kernel.cat
> > > +++ b/tools/memory-model/linux-kernel.cat
> > > @@ -34,6 +34,16 @@ let R4rmb = R \ Noreturn	(* Reads for which rmb works *)
> > >   let rmb = [R4rmb] ; fencerel(Rmb) ; [R4rmb]
> > >   let wmb = [W] ; fencerel(Wmb) ; [W]
> > >   let mb = ([M] ; fencerel(Mb) ; [M]) |
> > > +	(*
> > > +	 * full-barrier RMWs (successful cmpxchg(), xchg(), etc.) act as
> > > +	 * though there were enclosed by smp_mb().
> > > +	 * The effect of these virtual smp_mb() is formalized by adding
> > > +	 * Mb tags to the read and write of the operation, and providing
> > > +	 * the same ordering as though there were additional po edges
> > > +	 * between the Mb tag and the read resp. write.
> > > +	 *)
> > > +	([M] ; po ; [Mb & R]) |
> > > +	([Mb & W] ; po ; [M]) |
> > 
> > I couldn't help suggestting:
> > 
> > 	([M] ; po ; [Mb & domain(rmw)]) |
> > 	([Mb & range(rmw)] ; po ; [M]) |
> > 
> > , it's a bit more clear to me, but maybe the comment above is good
> > enough?
> 
> Hm, maybe clarity is in the eye of the beholder in this case.
> 
> Actually looking at your suggestion makes me think of smp_store_mb(), which
> although represented as Once;F[Mb] could be (mis)understood also as Mb&W.
> And it indeed does the same thing
>   ([Mb & W] ; po ; [M])
> would suggest.
> 
> (btw I think it is confusing that smp_store_mb is not strictly stronger than
> smp_store_release. Of course there are places where you want a relaxed store
> followed by an mb, but usually the mb versions are strictly stronger.).
> 

May not be a good idea to model smp_store_mb() as a (Mb & W), since the
purpose of smp_store_mb() is for SB pattern synchronization. Maybe it
has a bad name, but I think the intentation of smp_store_mb() is simply
a write + smp_mb(), rather than a MB write.

Regards,
Boqun

> Best wishes,
>   jonas
> 


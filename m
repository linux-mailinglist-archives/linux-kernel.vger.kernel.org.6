Return-Path: <linux-kernel+bounces-366993-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBECD99FD67
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 02:52:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DFF341C21A08
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 00:52:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 480AE14277;
	Wed, 16 Oct 2024 00:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IqzouTv0"
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C8314C83
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 00:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729039919; cv=none; b=epp2mfUxpBuR51B/wsN+AVa6Mu+v8eYv1e9aD22DTH3V8fUDDz8FD9rhkQVjhBEXkPhgnwO5T0KwtZ5SzLSIs2wtjjuF5xrx6bIVr71Qxw/CTJw2WMaNaOzrzBVR7mpOMl+hiTTwrwUc0D9Ivfca1ZfiMH4euCs/6dfRvci0K4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729039919; c=relaxed/simple;
	bh=lvQAaI+w4z9F1crM3ZpQSlO1sVnEyqYziZ32HHIrOlo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gyATWsrVNyfoXgv4ijMWj66TESgnoqQNe0/HJuiobnzC18ywfeUJKNEqxA+Uh5OJ03bTapQGhylppEq9pFfHrkUIQi+ZtOOiS3uFBL31PEaLua+HW2jnCV5e2RDtQhWuxwDMF0S0CLCFr+sPvExb0kv3NjNUJGiXtWdgFLoZ/1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IqzouTv0; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-7b10e0fadbcso487024285a.2
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 17:51:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729039917; x=1729644717; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:from:to:cc:subject:date:message-id:reply-to;
        bh=xRx4Wmm4TJzRW7XjVrpEHKqlINTecy54T7rfW99RWJM=;
        b=IqzouTv0loGQ1ytyEvlbPr7QKtyeqjg0+Z85ka9ZhX+xl770YyuJNfAnkE8pEVvK2t
         reyA+3MjHw0JEEIwqQqaqHUcjVc4uhJogTEzyRQYJ5IHRT/e6KTXwDjr8pPVJV9NXfTf
         vifJLy63Y9I9KTeNts5pQHaCmNfVIGsqtjP0og81PWFXV6tsg4v4wjACtN8IcCS2BXto
         oadWF8/KGYrLEx8IdZS8QtIPK0x/yOpI+hK2UGrFyEv/hoy2U4D+ozF1rWuC9d44b3h4
         +zPBBAqGQuz2byt+WS/Vn1Fxy9mu9eNElqvBaaf8v9ZpJWA1vK8qdE2x9DM/RODsWLRx
         Xq0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729039917; x=1729644717;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xRx4Wmm4TJzRW7XjVrpEHKqlINTecy54T7rfW99RWJM=;
        b=QnNw357z6DIO68dSLhMqQfoS2+qJJEtVRJuudOxoiIo3cH8SusrvNsZcAjHZI30GtO
         4Us3OrYgvOuJdq3gEMw7sNfy4SM8yo0MrcKXNTj9uaO4zdHkXa3nZBn7AEloDN5rz901
         qZ+f5D6DZ9cTtvGrTsZ5UWLTcMGFHr8aun3mQCin+7gD03O4S1dvK3tNWn7IcJFh0SGC
         SlboEvJ+dqoiHfgDHIDTr+cINTjaLzbb2Jp+7MGcrIv/C9Xxej4SH+kMCrp/RzDqHEtS
         3A8HRztwHVbLsBWy+ik0aKpz6dU3Mo5l4NuYUUmyImzrMz5gCHK/3hRXh57K/oBxFiAQ
         dHzQ==
X-Forwarded-Encrypted: i=1; AJvYcCVcSMTPm022bE3+8D9qMqN+8gxyPp1EtHwaRlHFTyQCRsYkekhD3T26Tpu1c0BiX0x1LyhidKXABkmX9xk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzufTAizK0j+l/CCoPcRiHnG/jyCLNLa+/MNFACXyYycOrqQ10E
	aCc/zGkoea/V3fcJWrc4cr6DNF9+zHZwWzDcLlhVqYF4V2m2MSk/
X-Google-Smtp-Source: AGHT+IHTZTC8KQW/V05drD9xVDgJEkMuI1LvoErlUJRzjkEvDCJRABN588CtwZ7SPo3og9HyKvG2rg==
X-Received: by 2002:a05:620a:17a9:b0:7a9:b856:434 with SMTP id af79cd13be357-7b1417abcb6mr271917185a.12.1729039917007;
        Tue, 15 Oct 2024 17:51:57 -0700 (PDT)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b1363cb3dbsm125464885a.127.2024.10.15.17.51.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2024 17:51:56 -0700 (PDT)
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfauth.phl.internal (Postfix) with ESMTP id D52A9120006D;
	Tue, 15 Oct 2024 20:51:55 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-07.internal (MEProxy); Tue, 15 Oct 2024 20:51:55 -0400
X-ME-Sender: <xms:Kw4PZzjEmZifS48RM-2U1EWmaljdF_EJ-0JMAYU6kNQZkyuZ6FANTQ>
    <xme:Kw4PZwD4WNt7Dvy1-5rzmfT2Hw8RvfjTd7fL8hZs6e2Jr4oNs4jDocM6qII-fn7G3
    vKPSzynLxFc0NtVYQ>
X-ME-Received: <xmr:Kw4PZzHwEeuyKfu6-xfRukOsKx_dtKgUKoDml2kNYHmxVy3n7eKIfXuTo4c>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdegkedgfeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdej
    necuhfhrohhmpeeuohhquhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilh
    drtghomheqnecuggftrfgrthhtvghrnhepjefhieekkeffjeeggeeuvefftdegfeduteel
    geejledvffetiefhleefhedvgeeknecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenuc
    evlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhquhhn
    odhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdeigedqudejje
    ekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfihigmhgvrdhn
    rghmvgdpnhgspghrtghpthhtohepjedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoh
    epqhhiuhiguhdriihhuhhosehinhhtvghlrdgtohhmpdhrtghpthhtohepphgvthgvrhii
    sehinhhfrhgruggvrggurdhorhhgpdhrtghpthhtohepmhhinhhgohesrhgvughhrghtrd
    gtohhmpdhrtghpthhtohepfihilhhlsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehl
    ohhnghhmrghnsehrvgguhhgrthdrtghomhdprhgtphhtthhopehlihhnuhigqdhkvghrnh
    gvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegsohhquhhnsehfihig
    mhgvrdhnrghmvg
X-ME-Proxy: <xmx:Kw4PZwS3fmRsDfaTcp2-xIGry8Fk_0XjAYr3MNZibichA6LeZ2YaMg>
    <xmx:Kw4PZwxJVQ6ptao4ASKYY2vcCWSEv4zwzP40ysuu5bOylJt1KGWvjQ>
    <xmx:Kw4PZ25-5_nxy55-2AqxpkKkstK0aycQ03KTReEOTdye2QGOPgHLZw>
    <xmx:Kw4PZ1w6LcfKHcmHydA4fkmxVjedK1-jL3Dy_KcX51g89L_CRlY2ww>
    <xmx:Kw4PZwhOMQ6ag8CwH8NGyov6CouLM29RKQH4EMX-H6PRiT0RXZ1I5lk5>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 15 Oct 2024 20:51:55 -0400 (EDT)
Date: Tue, 15 Oct 2024 17:51:53 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
Cc: "peterz@infradead.org" <peterz@infradead.org>,
	"mingo@redhat.com" <mingo@redhat.com>,
	"will@kernel.org" <will@kernel.org>,
	"longman@redhat.com" <longman@redhat.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/1] locking/pvqspinlock: Convert fields of 'enum
 vcpu_state' to uppercase
Message-ID: <Zw8OKZOme7Pk4W_2@Boquns-Mac-mini.local>
References: <20240805023816.28003-1-qiuxu.zhuo@intel.com>
 <20240809014802.15320-1-qiuxu.zhuo@intel.com>
 <CY8PR11MB71348DD03E5B112FAC1FDC9289442@CY8PR11MB7134.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CY8PR11MB71348DD03E5B112FAC1FDC9289442@CY8PR11MB7134.namprd11.prod.outlook.com>

On Mon, Oct 14, 2024 at 01:05:07PM +0000, Zhuo, Qiuxu wrote:
> Hi maintainers, 
> 
> > From: Zhuo, Qiuxu <qiuxu.zhuo@intel.com>
> > [...]
> > Subject: [PATCH v2 1/1] locking/pvqspinlock: Convert fields of 'enum
> > vcpu_state' to uppercase
> > 
> > Convert the fields of 'enum vcpu_state' to uppercase for better readability. No
> > functional changes intended.
> > 
> > Acked-by: Waiman Long <longman@redhat.com>
> > Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
> > ---
> > v1->v2:
> >  - Collect an ACK from Waiman (thanks for the review).
> >  - Rebase on top of v6.11-rc2.
> 
> Just a gentle reminder 😊. 
> Thanks!
> 

I've queued this in my lockdep-for-tip branch:

	https://git.kernel.org/pub/scm/linux/kernel/git/boqun/linux.git/log/?h=lockdep-for-tip

, and will send a PR to tip this week.

(Yes, this is not a lockdep patch, but it's trivial enough for me to
review myself and we have Waiman's Acked-by)

Regards,
Boqun

> [...]


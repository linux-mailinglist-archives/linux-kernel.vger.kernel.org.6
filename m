Return-Path: <linux-kernel+bounces-274086-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0921194733B
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 03:53:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8068B1F213C3
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 01:53:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0D6A3FB83;
	Mon,  5 Aug 2024 01:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GSruemL4"
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC5373BBCB
	for <linux-kernel@vger.kernel.org>; Mon,  5 Aug 2024 01:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722822825; cv=none; b=fOk8KZ4FajuRsqsaMmdTX8mFuIusYVMKzn5ZaQotWc0+yE7l6pNgI2aDckiw0y78VNoVaI2UoBNq97bndRPlthBJxLGTwUuaVuZ5rfNhAlVBu+Fx58c7IfJUmK+Odmqof66lgFsVbUqU1JFTE872L292PFhl15ou3xUKM4khJv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722822825; c=relaxed/simple;
	bh=JLb0hQ5bGIc2b3XGYDKCU3UdkjN/KNNRfzKK9znTFAU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=irLKMZGwOqdDqhjKQq6F9qT0OzLML8l76Zzls9IeQ81YNvZT/jjIA//44Z05EVqgnvJJBX/1LRIGNcZRrw1AOitoevXcR3FntshXVIWC5eWAKLL7WshTbX/kPQcgQcb7C3aodvfCylQEpQzbJDoZ8tVLcsQXGmSkXhlzVEVTqjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GSruemL4; arc=none smtp.client-ip=209.85.160.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-261e543ef35so5745369fac.3
        for <linux-kernel@vger.kernel.org>; Sun, 04 Aug 2024 18:53:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722822823; x=1723427623; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gGamAjYrrdAEeItzP4qz2BRS5pecyfrdaiZ5lvnoTEE=;
        b=GSruemL4Pdj4iOjEc+xPK27Rkm790mMLSZiNTG0RgbIZLMx9dDWIGt93FP16h45ujx
         Fw1lO/SFlMGHtBNMScqBClYaH7l88IeqoWPejplSCgNpH3BqcWJwKTPJ4pag8JsBWL5K
         50AFP0YinsLkpAR2hmnRrUtUQkst9CKhpoimwv2PvTmBRnlc89GyrvAofe6l2kIse/4c
         NObGL6xwh2rkkRqo/WtPOfYeaq430C88r5CTpe/Z/19nmavOecobC2eocXsLqMLcWV0B
         vZ63RTvtsNCRO+1b3Uk2rrCG4HLw5EW7hGiOKxY89jUuNoysiEhMEJJDbgrIYKOWsQoJ
         AZjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722822823; x=1723427623;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gGamAjYrrdAEeItzP4qz2BRS5pecyfrdaiZ5lvnoTEE=;
        b=CslL/uO05vZrsCTexK+wdtzgX3MUJIKX8abY5FJOMxdrZXRBrQBU4Lx0cxn61duhCT
         pvDc+BzoqIKMBC3La+XhdkNeCBq5vcTV2iHyeeWyRc9XdTfzeRwjZcS/G7uaUGvcdZ8e
         nAlJXfQqRPzl4Km4vMFJKG8U8pjhHrz0YUgVLDY/ceSY7gPPOYRsVMk923dom+FyCiOM
         sz0N+poAdpFoLguPDWkgpNpm3XPdNSyWd/UYFGBy4Qdlq1JI4s5Hv65+7/egStmLDHEb
         EnFeanXQUagGEu55QXrhLgMOQkEue5AIsjCfx9G2vNWx+LAzpw0UY6Tux2xZ08O7VrEc
         KyoA==
X-Forwarded-Encrypted: i=1; AJvYcCWQ/2hEfRpgi3GecCCTqP67uGOa3GcID1WJHDuJofY3+FMDum+8twtDhhWtKZl9Vqn+nKlFuhtyJee0pB5yiW+Q+MBs4P1plnBWCXO+
X-Gm-Message-State: AOJu0Yx9dJhrEwFQHZ60hw/EPitkR9lFgTmsNag3dA3T/2Fgo7FpRI5B
	vBETZW4LYoik3S/cyp45uYBfwLS7ABtSRSTTnrYXvjo8/Ue4zCbNmWxolQ==
X-Google-Smtp-Source: AGHT+IG9woPy8kOXY/EJAb0+8U2sGMNdAM/SNhh5aqT1feM8mWbNKoXnsgHxbcVBpRcy7bL+Ua1FiA==
X-Received: by 2002:a05:6871:79d:b0:260:ffaf:811b with SMTP id 586e51a60fabf-26891b27a2fmr12643856fac.11.1722822822639;
        Sun, 04 Aug 2024 18:53:42 -0700 (PDT)
Received: from localhost.localdomain ([2407:7000:8942:5500:aaa1:59ff:fe57:eb97])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7b762e9c6fesm4456632a12.11.2024.08.04.18.53.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Aug 2024 18:53:42 -0700 (PDT)
From: Barry Song <21cnbao@gmail.com>
To: chrisl@kernel.org
Cc: akpm@linux-foundation.org,
	baohua@kernel.org,
	hughd@google.com,
	kaleshsingh@google.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	ryan.roberts@arm.com,
	ryncsn@gmail.com,
	ying.huang@intel.com
Subject: Re: [PATCH v5 6/9] mm: swap: allow cache reclaim to skip slot cache
Date: Mon,  5 Aug 2024 13:53:24 +1200
Message-Id: <20240805015324.45134-1-21cnbao@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <CACePvbXkM1E56exMYKC5VsBFd+3+V60yPXx-qnq8ZNgOG1yVrg@mail.gmail.com>
References: <CACePvbXkM1E56exMYKC5VsBFd+3+V60yPXx-qnq8ZNgOG1yVrg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Mon, Aug 5, 2024 at 6:07 AM Chris Li <chrisl@kernel.org> wrote:

> > > > +
> > > > +       spin_lock(&si->lock);
> > > > +       /* Only sinple page folio can be backed by zswap */
> > > > +       if (!nr_pages)
> > > > +               zswap_invalidate(entry);
> > >
> > > I am trying to figure out if I am mad :-)  Does nr_pages == 0 means single
> > > page folio?
> > >
> >
> > Hi Barry
> >
> > I'm sorry, this should be nr_pages == 1, I messed up order and nr, as
> > zswap only works for single page folios.
> Ack. Should be  nr_pages == 1.
>

Yes. Andrew, can you please help squash the below fix,

small folios should have nr_pages == 1 but not nr_page == 0

diff --git a/mm/swapfile.c b/mm/swapfile.c
index ea023fc25d08..6de12d712c7e 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -224,7 +224,7 @@ static int __try_to_reclaim_swap(struct swap_info_struct *si,
 
 	spin_lock(&si->lock);
 	/* Only sinple page folio can be backed by zswap */
-	if (!nr_pages)
+	if (nr_pages == 1)
 		zswap_invalidate(entry);
 	swap_entry_range_free(si, entry, nr_pages);
 	spin_unlock(&si->lock);

> Barry, thanks for catching that.
>
> Chris

Thanks
Barry



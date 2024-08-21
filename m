Return-Path: <linux-kernel+bounces-296175-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BB3695A6AA
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 23:32:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 289BFB220DD
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 21:32:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0BBE17B4E2;
	Wed, 21 Aug 2024 21:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mary-zone.20230601.gappssmtp.com header.i=@mary-zone.20230601.gappssmtp.com header.b="uh/OfoMR"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63FC91791ED
	for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 21:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724275933; cv=none; b=gDmInibZtdQgqPqd0e1MMSdqHBVSo22Lc9Im5HzEwqCwELyy05cn08CB6mb5R3HRgC821aCyL/swXx8OJj3U3bcvLfo/goBkxch7CZIoB2PW0BLAhOVbkmFxkCQGujjKhlnuslA8ajDFUvYVWWUwZ2mvL0IX6B4oulqPQsOFNKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724275933; c=relaxed/simple;
	bh=G2ZYzUM9xPfjHf7MaE5c1ZAlligmTgj92iLVFjxn+BE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hrPC904xjmjddy5/2HmkKlVx7k+LIQd0daKMczxr4nr92QShM/AZrwqH+LaWBP+2OwjnjI35OQEU5MCHinKQdPdOuIL6VSemqwaj8T+zYJ9m+sAnknQcHtA3yGIPmlDP+b8GFG8TSlgEHKtVW8x7bDnccBrh8TgworM3osrOURY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mary.zone; spf=none smtp.mailfrom=mary.zone; dkim=pass (2048-bit key) header.d=mary-zone.20230601.gappssmtp.com header.i=@mary-zone.20230601.gappssmtp.com header.b=uh/OfoMR; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mary.zone
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mary.zone
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-427fc97a88cso808555e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 14:32:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mary-zone.20230601.gappssmtp.com; s=20230601; t=1724275928; x=1724880728; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=e8/UWu+nkogk+rrCqpk1JaTQfdH+a2mQFoDGBlja3Pc=;
        b=uh/OfoMRQ0N16C462jwQuK76cIxkdK5U8HxQbJgt6EgShlHzRRZUV8LQkQGEzoImbV
         SuE11IqpQWJ+gOXlPjFfmeyG1qiJJbFAwX204Xw3tshleNipwZ+DUHAyjGq7PXDsiPGy
         9q6YhJgeXp935es4psJDFi6bqL7nCTuIuHs1sziOiLLpdc0QjyZEn/l424p03bMH/Jsy
         IZ5aMhAHTIjPzAI5kwhWLOj8kg/FVX9heJrtsyzEHNHG/lCq1h5IWc/zBssB/VIRinED
         5TYzl36azXCoKZhVBwirTPbBOtrVZmiD9W5QKRunM1RExyhFJWA/BrQWOgB/f6QHdZhe
         KN+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724275928; x=1724880728;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e8/UWu+nkogk+rrCqpk1JaTQfdH+a2mQFoDGBlja3Pc=;
        b=k1eRTMhocPGiSqBh3+fEeX0+J1Gciden/0FYLsgB2PXIHaQRUu9T6rVU/4LAXdiSy0
         hovKht9H8htsDzsv0V2ztkICz9WNCllTvsYRRUmxpxDS+elXY/ImC846WmkDpWs93HMx
         SyojfrdQNfa0mZTNmTJblEOxX/v/PPvsp18bvjQVW4o6p8NEfN/WlSdhtiJPO8G+6bk/
         TIFApo0ZUdn+pzKkRclAINcK/pzSKx5pvkmNkaZ8sFRZzopliJgdLryiMc+Pec1Ajfe0
         1baYNktNcTmlS6of1+gJFZtRl0U0YC28w9bR0WAcFB/zRyzVNqsk31F54RoBeIMB0+4u
         wByQ==
X-Forwarded-Encrypted: i=1; AJvYcCV5ofF9VqLLE8zUwkZzjjOWCmJ3f/yV3smwkxPsxl4ckgg4iMHc9Ti1i43Bs4DkfD7TZg64nzMBxq+qOyo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1yRZrC+TgzsV91gNFjVc6PATfvuMtb9ScJL8IT85z7MIEXMDM
	f8+fB9317xKb07z/lHcAEqArUyYtMMamLDNIdFknVX96PPvlKppck6PqO6XIsHYAU8Ukr4fVny7
	AuIoWzw==
X-Google-Smtp-Source: AGHT+IHKJLdclZTFijLA7DW5BcP/iaYLqoD8ipe3pdpTBJexDaFe7tQ5JwO0ExnL7fnrsWAfryPdzA==
X-Received: by 2002:a05:600c:5486:b0:426:5f8f:51a4 with SMTP id 5b1f17b1804b1-42abd22ffd0mr25332835e9.12.1724275928297;
        Wed, 21 Aug 2024 14:32:08 -0700 (PDT)
Received: from kuroko.kudu-justice.ts.net (2a01cb040b5eb100cb3bcc29e5f2b7ed.ipv6.abo.wanadoo.fr. [2a01:cb04:b5e:b100:cb3b:cc29:e5f2:b7ed])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3730815b7e3sm23778f8f.53.2024.08.21.14.32.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2024 14:32:07 -0700 (PDT)
Date: Wed, 21 Aug 2024 23:32:06 +0200
From: Mary Guillemard <mary@mary.zone>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Manivannan Sadhasivam <manisadhasivam.linux@gmail.com>,
	linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
	Peter Wang <peter.wang@mediatek.com>,
	Stanley Jhu <chu.stanley@gmail.com>,
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH 1/1] scsi: ufs-mediatek: Add UFSHCD_QUIRK_BROKEN_LSDBS_CAP
Message-ID: <ZsZc1jYL8wSZZYSw@kuroko.kudu-justice.ts.net>
References: <20240818222442.44990-2-mary@mary.zone>
 <20240818222442.44990-3-mary@mary.zone>
 <20240819120852.tdxlebj7pjcxjbou@thinkpad>
 <ZsOJKMg8xlpdgoi5@kuroko.kudu-justice.ts.net>
 <20240820060946.ktiysu7sn7qgbwx4@thinkpad>
 <223cc3ca-9214-4ba1-a3c8-2d672aef52f9@acm.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <223cc3ca-9214-4ba1-a3c8-2d672aef52f9@acm.org>

On Tue, Aug 20, 2024 at 02:50:58PM -0700, Bart Van Assche wrote:
> On 8/19/24 11:09 PM, Manivannan Sadhasivam wrote:
> > On Mon, Aug 19, 2024 at 08:17:10PM +0200, Mary Guillemard wrote:
> > > On Mon, Aug 19, 2024 at 05:38:52PM +0530, Manivannan Sadhasivam wrote:
> > > > On Mon, Aug 19, 2024 at 12:24:42AM +0200, Mary Guillemard wrote:
> > > > > +	if (host->caps & UFS_MTK_CAP_DISABLE_MCQ)
> > > > 
> > > > How can this be the deciding factor? You said above that the issue is with
> > > > MT8183 SoC. So why not just use the quirk only for that platform?
> > > 
> > > So my current assumption is that it also affect other Mediatek SoCs
> > > that are also based on UFS 2.1 spec but I cannot check this.
> > > 
> > > Instead, we know that if MCQ isn't supported, we must fallback to LSDB
> > > as there is no other ways to drive the device.
> > > 
> > > UFS_MTK_CAP_DISABLE_MCQ (mediatek,ufs-disable-mcq) being unused upstream,
> > > I think that's an acceptable fix.
> > > 
> > 
> > If you use this quirk, then you need to use the corresponding DT property. But
> > using the 'mediatek,ufs-disable-mcq' property for 2.1 controller doesn't make
> > sense as MCQ is for controllers >= 4.0.
> > 
> > > Another way to handle this would be to add a new dt property and add it
> > > to ufs_mtk_host_caps but I feel that my approach should be enough.
> > > 
> > 
> > No need to add a DT property. Just use the SoC specific compatible as I did for
> > SM8550 SoC.
> 
> Mary, do you plan to implement Manivannan's feedback?
> 
> Thanks,
> 
> Bart.
>

Hello Bart,

I think that considering Peter's reply, explicitly checking for the
MT8183 controller isn't required.

I also think it could be required for at least the MT8192 and MT8195
considering they are apparently also based on UFS 2.1 spec [1].

However, if you want me to add an explicit check, I will happily send a
v2.

Thanks,

Mary.

[1]https://corp.mediatek.com/news-events/press-releases/mediatek-announces-new-mt8192-and-mt8195-chipsets-designed-for-next-generation-of-chromebooks




Return-Path: <linux-kernel+bounces-427924-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4F769E0B7D
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 20:02:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 09D8CB261FE
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 15:49:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFD8A4204D;
	Mon,  2 Dec 2024 15:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="ZeKIc3p+"
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 377BF134AC
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 15:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733154539; cv=none; b=GdkbagJaQtQ+l+VdM3xhQlkx1miNAFBqY5TtvNG3ciP5b7YYzc7q0woZmPdhAUA7DE2aTCrTrq0mMLP9ZYiTPmtVO1A7EzSKHDtINWdjD9NAi5F1x2mq9zHnasv2w8+n2d19b7SrxNbpUeAIKZ9u4RYQKJo0Ss5XoHEkU5LnKN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733154539; c=relaxed/simple;
	bh=cg0oqekGdROxXgWjUjGc1PUHp+3SPTuQPtEAfVpKyAE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eKAfqRIWJHL9oBYJl/d+pvNpKybLOvdmYpfzmOV6UfEv5fBDQpprZ2pEC1zjEfFOEPE9SRtf3/oLEgXDFhCvlfyr9/9NdXZa5pqjSYmntlKoF2wk7D76Lv7/jzJtnBNmEztSbyzNCYoHcMuthJO91OBJO57BtH7FmL5SuA/RmzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=ZeKIc3p+; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6d8a13444fcso11714716d6.3
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2024 07:48:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1733154536; x=1733759336; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=V4p+TEBI7XBsMdBO8dWrGfiuYElGa1lAn8SrYeUTVGQ=;
        b=ZeKIc3p+GBl67eUKH2vifY0I6bQF+rimEXCMdfpOUjU++8eCnRGbl+iTb2Zb5BW8qT
         3eWmQ17gNnpK4GdXsBNQ/uuQJvMyl6j4yphTzH771mgImIINF62/8alJmZXDuLnKx+Es
         jgOPd4ExTY/omHiV6ms8LTNsmph4x38WZCfOpYmj13DAvC9jyqnD8XUhQavbIJ6hr46V
         DRa64tPanohjSWRM+pU4qFOQgQZg68WeG4insZz5idyOyfpiqaORXk435OA3GyYfmVPu
         PKeiWjL/9hPlcwyeclxLBm2rIPNd0hQQ3P7ClvrrS/ILyEZLgyzjEgqNvcU9A18CYIs4
         Am4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733154536; x=1733759336;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V4p+TEBI7XBsMdBO8dWrGfiuYElGa1lAn8SrYeUTVGQ=;
        b=q/CBrFet2FwvHWuLEAeA8cL6/qOk2qVC9pcTU+1BXI2IzPCl6un4ZDMMAFp8LrBC9F
         Cy7l0QGOtOPjRkVVV5pqsxKtTydaB6yBfBu1SWEW9lpEUoHL5VG/NlERTge82lHt+hBr
         cxbe+gDxJTg7xUsavguw9zIf9paJSRcGHPeWJ2Sw2WUQrvy9mDkER0edglEPWgXwX4ym
         v9KtsvGaTLm4sL7pmiL227m4cjTnE0HeTUYeiaU7zZBkXoyAukJ2pouHwuKkCW8DnDN+
         IjqM9pflSR9obJZWYms3GvBfSp+eLHbxo/r3RNkbxU0N/UfaGrLl1Ky+jNkSE8H5NRdg
         Kztw==
X-Forwarded-Encrypted: i=1; AJvYcCWe+hFNX4oAncVy7tJTEGQELaARH80iASYQMSz+uGBOYANhzVT/A/skz4AaBKVYFsIM8GhwEcFPIKBEWW4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3ZoYOrbTstQZSyh35ZYbxrdx5RMlvurDLi5lEvuXUxnl3VYnA
	iP+BLGAO08wE8IJQqW1j0V8olQbVqoFYOJSo8JpHYMG9efhgYaJzpSKCy/YoZeA=
X-Gm-Gg: ASbGncug60CeHlTn7X1lNYFF4vd7aFUTKW2VJ9AenFapEq67PLVYN8SdVArE0kAH9cn
	/5lWw4qKRLVpFD5l3fvejRnoaW2RTx5SW4PFf0oVski0FAtCUIBxGaXhwjFtiXy9LIYCQ9HPcEO
	uLkUP5hKiFgc+RO8iMFtVHSnfLnL6TiK0VeBSudIaDUL8Ag61RDa7D+vX6DuiXBFIUwT7l7y6LV
	7gtij8yOf2Fs7TBb9yde0HmIGLlgoSXwY5t1mlXaGaV9DyZTO4JavUGK2lPIkkHR4+y6RIK7qy2
	SNhS99kDUYQQGQ8fQpAnV8JZg71OES/a7Aw=
X-Google-Smtp-Source: AGHT+IEulJRL9u1e9RepECbKzcJd1o9PSsLDmrn97VXIt8vpMeObeRiPDfAJJDxtOp1H2udplj80uQ==
X-Received: by 2002:a05:6214:2308:b0:6d4:1c9d:4f47 with SMTP id 6a1803df08f44-6d864d25b2cmr298319886d6.13.1733154535946;
        Mon, 02 Dec 2024 07:48:55 -0800 (PST)
Received: from PC2K9PVX.TheFacebook.com (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d8ad3e2e76sm6490016d6.78.2024.12.02.07.48.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2024 07:48:55 -0800 (PST)
Date: Mon, 2 Dec 2024 10:47:57 -0500
From: Gregory Price <gourry@gourry.net>
To: "Huang, Ying" <ying.huang@linux.alibaba.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, nehagholkar@meta.com,
	abhishekd@meta.com, kernel-team@meta.com, david@redhat.com,
	ying.huang@intel.com, nphamcs@gmail.com, akpm@linux-foundation.org,
	hannes@cmpxchg.org, feng.tang@intel.com, kbusch@meta.com
Subject: Re: [PATCH 1/4] migrate: Allow migrate_misplaced_folio APIs without
 a VMA
Message-ID: <Z03WrdqWV1NBf1NA@PC2K9PVX.TheFacebook.com>
References: <20241127082201.1276-1-gourry@gourry.net>
 <20241127082201.1276-2-gourry@gourry.net>
 <87plmfeho4.fsf@DESKTOP-5N7EMDA>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87plmfeho4.fsf@DESKTOP-5N7EMDA>

On Thu, Nov 28, 2024 at 07:12:11PM +0800, Huang, Ying wrote:
> Hi, Gregory,
> 
> Gregory Price <gourry@gourry.net> writes:
> 
> > To migrate unmapped pagecache folios, migrate_misplaced_folio and
> > migrate_misplaced_folio_prepare must handle folios without VMAs.
> 
> IMHO, it's better to use migrate_misplaced_folio() instead of
> migrate_misplaced_folio for readability in patch title and description.
> 
> > migrate_misplaced_folio_prepare checks VMA for exec bits, so allow
> > a NULL VMA when it does not have a mapping.
> >
> > migrate_misplaced_folio must call migrate_pages with MIGRATE_SYNC
> > when in the pagecache path because it is a synchronous context.
> 
> I don't find the corresponding implementation for this.  And, I don't
> think it's a good idea to change from MIGRATE_ASYNC to MIGRATE_SYNC.
> This may cause too long page access latency for page placement
> optimization.  The downside may offset the benefit.
> 
> And, it appears that we can delete the "vma" parameter of
> migrate_misplaced_folio() because it's not used now.  This is a trivial
> code cleanup.
>

This patch apparently got a bit away from me and was heavily reduced
from its initial form.  This commit message is just wrong now.  I will
update this and the 2nd commit and probably submit them separately.

~Gregory
 


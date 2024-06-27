Return-Path: <linux-kernel+bounces-231906-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5A0991A02B
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 09:15:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 01D971C21044
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 07:15:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 093974D9FE;
	Thu, 27 Jun 2024 07:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uZ/ykt0b"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AA6F4D8A4;
	Thu, 27 Jun 2024 07:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719472476; cv=none; b=rW4G8t6jBTjWF/cz6h/TIvD7nBL43M2InDGfiTszQvMYXdTCAaHx39NeRtKQrS8XhpEP7/c4SorOfmzleEj36Q1w+udboWQSzUH4h12+OhEsHQy00wKI2xtKdL4zzGz9v1ytJfBb2il9jZGG373myDjfDLpQFmzzTW+eWrnJZZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719472476; c=relaxed/simple;
	bh=po6sWyrFWew/mEgOCGOEB2oznE/qGvJjuvegU6U6f8c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tWCghXxOb3m/vUEzoFBe8bXT0Gug3c8/2/mMK8LBZfwl5K453gbi7B/PnFKp5UIx7vppzCfQ5/ef4ss2T5HyPInUiPdt3H1KYzxT7SfYm9z/2XWBiJfNwe3dUCsULneLuLUpTgI2HckuO7/fWvZt0tOlCcbEKLyw0jCGUzR5CX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uZ/ykt0b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D88F9C2BBFC;
	Thu, 27 Jun 2024 07:14:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719472475;
	bh=po6sWyrFWew/mEgOCGOEB2oznE/qGvJjuvegU6U6f8c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uZ/ykt0bR/9aFwtj/gDxjCHjc+TDfW5iINdPHl3zedegTkJPafF6W7SrW+wOeWF8p
	 9rifOPzuhs8V3PWslyIyJ8iKpq1VlG5X1fXE/wQktV5EaExutpxYDPDya2bDII80rw
	 py5sFdzz4PAUiKaM6saUxnPdRBgDlmaQvme8P8x+ktLswbfl/BS5TqefyOvVdA8YA5
	 eXbMvMFqlRvG7UbnuT6GuU0sFQwa18UtERtwrXdXj3+YM+iQ1qwnuk5CaAA8l3zYOx
	 Et272YAQxQIsPsC0e8Eny9777pIk3DDcPVj4+A4RSXCvrxAZ8GxfeVbVRxM0XoeI3w
	 hiYIGnMb04OSw==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1sMjLE-000000000Tt-3r4l;
	Thu, 27 Jun 2024 09:14:48 +0200
Date: Thu, 27 Jun 2024 09:14:48 +0200
From: Johan Hovold <johan@kernel.org>
To: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: Paul Spooren <mail@aparcar.org>, Corentin Labbe <clabbe@baylibre.com>,
	gregkh@linuxfoundation.org,
	linux-kernel <linux-kernel@vger.kernel.org>,
	linux-usb@vger.kernel.org, david@ixit.cz
Subject: Re: [PATCH 1/1 v7] usb: serial: add support for CH348
Message-ID: <Zn0RaATKGAn2Ja3b@hovoldconsulting.com>
References: <20240507131522.3546113-1-clabbe@baylibre.com>
 <20240507131522.3546113-2-clabbe@baylibre.com>
 <A4B2BDF4-263F-4879-A0C3-399D8A1BF3FE@aparcar.org>
 <CAFBinCBwCCKUS1k0Qb0GttucF3_Nn6CJUTe090RV5AD4CDM-NQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFBinCBwCCKUS1k0Qb0GttucF3_Nn6CJUTe090RV5AD4CDM-NQ@mail.gmail.com>

On Sat, Jun 22, 2024 at 09:00:17PM +0200, Martin Blumenstingl wrote:
> On Wed, Jun 19, 2024 at 3:35 PM Paul Spooren <mail@aparcar.org> wrote:
> > > On 7. May 2024, at 15:15, Corentin Labbe <clabbe@baylibre.com> wrote:
> > >
> > > The CH348 is an USB octo port serial adapter.
> > > The device multiplexes all 8 ports in the same pair of Bulk endpoints.
> > > Since there is no public datasheet, unfortunately it remains some magic values
> > >
> > > Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
> > Tested-by: Paul Spooren <mail@aparcar.org <mailto:mail@aparcar.org>>

> Thanks Paul!
> Johan, is the Tested-by something that you can fix up while applying?

Sure.

> Speaking of applying this patch, it would be great to have it queued
> for Linux 6.11.
> If you have any questions or review comments then please let Corentin
> and me know.

If you think the outstanding issues have been addressed now then I'll
find some time to review it again.

Johan


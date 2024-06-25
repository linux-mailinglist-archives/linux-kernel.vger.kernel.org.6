Return-Path: <linux-kernel+bounces-228533-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E459A916161
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 10:34:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A1751F21393
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 08:34:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 702D8149C7A;
	Tue, 25 Jun 2024 08:33:08 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42D42149C45
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 08:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719304388; cv=none; b=IjCOCc5kRNPElXMy4dkPujfJV8vEfINyYhZyEY9mCfMKyu94W98UIkkn/CDbA6kVijBvkNZA9bPFq7sBo6AScdB3yXb3w0pQ3zO8VF69W+0B82LLC5E+RirqP3iqEi8F5oR4zawuAzNqQAH6Kny6jl6cgrFmYnokQ5jqO0KkRQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719304388; c=relaxed/simple;
	bh=BAC4cTMVD1u8CmBSnANIr+EbJBSCJ8Py+C49dJT7/kM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EIheQ8b+mBj4SKwcH02/g/iH/u8XJRnEXK1/SGBaIm1Bj0YnF4GYiF/uSP121vyLBp5Ku24tiRqQJziUyMxnSe2CMOKjEkxkge80Lk0V6p6gJbqoaGInTDYEy8RxOzJzXzNkicBjTT7l6QAmOuSGQn3++hwj1Zui4xFeO1ubcSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mfe@pengutronix.de>)
	id 1sM1bf-0002Bf-70; Tue, 25 Jun 2024 10:32:51 +0200
Received: from [2a0a:edc0:2:b01:1d::c5] (helo=pty.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mfe@pengutronix.de>)
	id 1sM1be-004qca-KI; Tue, 25 Jun 2024 10:32:50 +0200
Received: from mfe by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <mfe@pengutronix.de>)
	id 1sM1be-00E3rT-1l;
	Tue, 25 Jun 2024 10:32:50 +0200
Date: Tue, 25 Jun 2024 10:32:50 +0200
From: Marco Felsch <m.felsch@pengutronix.de>
To: Andrei Lalaev <andrey.lalaev@gmail.com>
Cc: dmitry.torokhov@gmail.com, robh@kernel.org, linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Andrei Lalaev <andrei.lalaev@anton-paar.com>
Subject: Re: [PATCH] Input: qt1050 - handle CHIP_ID reading error
Message-ID: <20240625083250.jcgfszu6plkopouu@pengutronix.de>
References: <20240617183018.916234-1-andrey.lalaev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240617183018.916234-1-andrey.lalaev@gmail.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

On 24-06-17, Andrei Lalaev wrote:
> From: Andrei Lalaev <andrei.lalaev@anton-paar.com>
> 
> If the device is missing, we get the following error:
> 
>   qt1050 3-0041: ID -1340767592 not supported
> 
> Let's handle this situation and print more informative error
> when reading of CHIP_ID fails:
> 
>   qt1050 3-0041: Failed to read chip ID: -6
> 
> Fixes: cbebf5addec1 ("Input: qt1050 - add Microchip AT42QT1050 support")
> Signed-off-by: Andrei Lalaev <andrei.lalaev@anton-paar.com>

Reviewed-by: Marco Felsch <m.felsch@pengutronix.de>


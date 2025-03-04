Return-Path: <linux-kernel+bounces-543376-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A8ACA4D4D5
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 08:29:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9DB39188ED1F
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 07:29:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 138521F666B;
	Tue,  4 Mar 2025 07:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cxBZmQBO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 731791F5616;
	Tue,  4 Mar 2025 07:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741073356; cv=none; b=e78Sp+iDsA2fe5+t5XCAUvizuSfmytSO3cKV8LLX++Sy1MCtl3dFnRn9jAaium+ou1hgoAC8lTIHGFHn/bQUpzF7aC5ohuzmxxke/Qb6VRNF7XLuVkyc2SivnfahScPZ2qSLNLoi1DAHHvhIJunt2qcym6/c+yEcgX2VrRuoQ2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741073356; c=relaxed/simple;
	bh=swTTp6zmW3O4dO482meuxSb7B6i+rUviD2UQp5Olb6o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Anfqn0pzQw9X6vWM8eAOAWpF9l/oj8KS4HAsRbQVwIvcu2+zBv0/MSiiDNm8UAStWJhOaDLsx+3/1UQipMgLMf0pbXBAyPmIznjLnSuZeKECIPG2yUiL24kPjZlUGVPLDlo97K4OcYCRZfNAqpSyHlger7gWozMTOdhF1wHiq84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cxBZmQBO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D61B5C4CEE5;
	Tue,  4 Mar 2025 07:29:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741073355;
	bh=swTTp6zmW3O4dO482meuxSb7B6i+rUviD2UQp5Olb6o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cxBZmQBO8oOHl/I66uJepXzW8QK4P3mIlwHvzWamPfAau8b1W8DDJxiDRUL2LFGCm
	 dq1eqbELNLEBqMuTJem7QN828kTboJ+L78ReY+R7KlBtdZ2EWYzpsheTuZeqTl6VpZ
	 JmkMIStgTRUBUV+ASChCNPu3SUYZN0A6KAZ5oCTxgr/GF/QmZILhqT7YGp+S0EToTP
	 BRWpORcGkAVYiKecR8uIcnOEVVNNpL3UjwShVAsFFGOXoDzK8GUm9+QbaAL6O71H3d
	 053JXc9juXRk4Tr/UvolKLpF0f6SUkT+9Fr5zgGpET+gbVlbykosSLKPC9a5IUJOxo
	 /H2Zr52zJfg3A==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1tpMiE-000000000BI-29a7;
	Tue, 04 Mar 2025 08:29:10 +0100
Date: Tue, 4 Mar 2025 08:29:10 +0100
From: Johan Hovold <johan@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Ng, Boon Khai" <boon.khai.ng@intel.com>
Cc: "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"Ang, Tien Sung" <tien.sung.ang@intel.com>,
	Tien Sung Ang <tien.sung.ang@altera.com>,
	Boon Khai Ng <boon.khai.ng@altera.com>
Subject: Re: [PATCH v1] USB: serial: ftdi_sio: add support for Altera USB
 Blaster 3
Message-ID: <Z8arxlXNKF45n0Nr@hovoldconsulting.com>
References: <20250203084822.18356-1-boon.khai.ng@intel.com>
 <DM8PR11MB5751CB62C7A68840F9AC7F9DC1C82@DM8PR11MB5751.namprd11.prod.outlook.com>
 <2025030429-saddlebag-acrobat-21d8@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2025030429-saddlebag-acrobat-21d8@gregkh>

On Tue, Mar 04, 2025 at 06:32:46AM +0100, Greg Kroah-Hartman wrote:
> On Tue, Mar 04, 2025 at 05:25:38AM +0000, Ng, Boon Khai wrote:

> > I'm writing to follow up on this patch I submitted for the USB FDTI driver to update the VID and PID about a month ago. 
> > 
> > I wanted to kindly check in and inquire if there are any updates regarding the review or integration of the patch.
> > If there are any issues or additional information required from my side, please let me know how I can assist in moving it forward.

> Should be in Johan's queue somewhere, if not, please just resend it.

It's still in my queue. I plan to do another pass this week so I'll get
back to you shortly.

Johan


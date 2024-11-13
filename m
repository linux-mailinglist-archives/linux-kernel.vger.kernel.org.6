Return-Path: <linux-kernel+bounces-407402-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C2039C6CFE
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 11:37:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 132CB1F2278C
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 10:37:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2F091FE0EB;
	Wed, 13 Nov 2024 10:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tecnico.ulisboa.pt header.i=@tecnico.ulisboa.pt header.b="i0AznSW2"
Received: from smtp1.tecnico.ulisboa.pt (smtp1.tecnico.ulisboa.pt [193.136.128.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F100F18A6D1
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 10:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.136.128.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731494269; cv=none; b=Iz+TE8lSBEpOW84GBRuzjmxIhyaobLL8xyIvWjbbtSkgEy+5/tEsTWL4MiXkwkc0sGI+cqGUCQ9Msciv9g+LLArQEMsJnAGSLP7P5/mbzr242OCoaC90HHkJ+/N95yOmGqd+ZPzhgssHwx9YhDoaSGQ2wFsUieYYB674FP8Nrpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731494269; c=relaxed/simple;
	bh=ccZyF2YdctOG/jDywK4v0Y0OCscfIVmrLzvgDchdxdM=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=PQ1MFASu7pAwMWqlVC6/bBEdpPxZ3e8u+G0lOe1S67VBPMycpCCMTg2WO9gM3+eXF6r3h9mIqNbMZMmS13OydISrarQ8afz4hMRFRWYVYgNK8FrzgbiMwu07TgCQ07A/mxHGID6A+8iE3MlRY7Xjxa8eDF06cWTLYD88vey+ecU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tecnico.ulisboa.pt; spf=pass smtp.mailfrom=tecnico.ulisboa.pt; dkim=pass (1024-bit key) header.d=tecnico.ulisboa.pt header.i=@tecnico.ulisboa.pt header.b=i0AznSW2; arc=none smtp.client-ip=193.136.128.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tecnico.ulisboa.pt
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tecnico.ulisboa.pt
Received: from localhost (localhost.localdomain [127.0.0.1])
	by smtp1.tecnico.ulisboa.pt (Postfix) with ESMTP id 0ADF06002995;
	Wed, 13 Nov 2024 10:28:04 +0000 (WET)
X-Virus-Scanned: by amavis-2.13.0 (20230106) (Debian) at tecnico.ulisboa.pt
Received: from smtp1.tecnico.ulisboa.pt ([127.0.0.1])
 by localhost (smtp1.tecnico.ulisboa.pt [127.0.0.1]) (amavis, port 10025)
 with LMTP id ImfuLPTuPxcW; Wed, 13 Nov 2024 10:28:01 +0000 (WET)
Received: from mail1.tecnico.ulisboa.pt (mail1.ist.utl.pt [193.136.128.10])
	by smtp1.tecnico.ulisboa.pt (Postfix) with ESMTPS id 67CB2600299D;
	Wed, 13 Nov 2024 10:28:01 +0000 (WET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tecnico.ulisboa.pt;
	s=mail; t=1731493681;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ccZyF2YdctOG/jDywK4v0Y0OCscfIVmrLzvgDchdxdM=;
	b=i0AznSW2+eCaAbs0rXf2fNSw0BDaUMiCp4ZfpzPLw34VIusbw4RkQZZ0uNvfEzmt6WZht7
	kEUskLavCse2gMzGyVuhqUMx51AXF096dE4yLqEVfhsArQSx1f91jz1Zp7u24Gn5xBT29F
	GPpJEZ6QsHx84mZ+AE65ACeewSvp9fw=
Received: from localhost (unknown [165.225.92.235])
	(Authenticated sender: ist187313)
	by mail1.tecnico.ulisboa.pt (Postfix) with ESMTPSA id 444D636015A;
	Wed, 13 Nov 2024 10:27:59 +0000 (WET)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 13 Nov 2024 10:27:53 +0000
Message-Id: <D5KZA4FBPDXD.2NKXWOH7UM2VJ@tecnico.ulisboa.pt>
Cc: <kherbst@redhat.com>, <linux-kernel@vger.kernel.org>, <dakr@redhat.com>,
 <lyude@redhat.com>, <bskeggs@nvidia.com>, <simona@ffwll.ch>,
 <dri-devel@lists.freedesktop.org>, <nouveau@lists.freedesktop.org>, "Danilo
 Krummrich" <dakr@kernel.org>
Subject: Re: [REGRESSION] GM20B pmu timeout
From: "Diogo Ivo" <diogo.ivo@tecnico.ulisboa.pt>
To: "Dave Airlie" <airlied@gmail.com>, "Linux regressions mailing list"
 <regressions@lists.linux.dev>
X-Mailer: aerc 0.18.2-0-ge037c095a049
References: <20241010133253.30311-1-diogo.ivo@tecnico.ulisboa.pt>
 <041511ee-4556-422a-8604-30b5e0dfd21c@leemhuis.info>
 <D5DDUQJOZ4HW.1XDOASECJR714@tecnico.ulisboa.pt>
 <44c39c87-90e2-4a74-a185-752c14f6d711@leemhuis.info>
 <CAPM=9txeL+WxYuuGYyhGouXYC0=Y=YS=k=-4G74JbfT2mvkn2g@mail.gmail.com>
In-Reply-To: <CAPM=9txeL+WxYuuGYyhGouXYC0=Y=YS=k=-4G74JbfT2mvkn2g@mail.gmail.com>

Hi Dave,

On Tue Nov 12, 2024 at 7:59 PM WET, Dave Airlie wrote:
> On Tue, 12 Nov 2024 at 22:34, Linux regression tracking (Thorsten
> Leemhuis) <regressions@leemhuis.info> wrote:
> >
> > [CCing Danilo, who committed the culprit]
> >
> > On 04.11.24 13:11, Diogo Ivo wrote:
> > > On Tue Oct 15, 2024 at 7:13 PM WEST, Linux regression tracking (Thors=
ten Leemhuis) wrote:
> > >> On 10.10.24 15:32, Diogo Ivo wrote:
> > >>>
> > >>> Somewhere between 6.11-rc4 and 6.11-rc5 the following error message=
 is displayed
> > >>> when trying to initialize a nvc0_screen on the Tegra X1's GM20B:
> > >>>
> > >>> [ 34.431210] nouveau 57000000.gpu: pmu:hpq: timeout waiting for que=
ue ready
> > >>> [ 34.438145] nouveau 57000000.gpu: gr: init failed, -110
> > >>> nvc0_screen_create:1075 - Error allocating PGRAPH context for M2MF:=
 -110
> > >>> failed to create GPU screen
> > >>
> > >> Thx for the report. Hmmm. No reply so far. :-/
>
> Apologies for the delay and thanks to Thorsten for bringing it up again,
>
> Does the attached patch fix it?

Yes, the GPU is booting again. Thanks for looking into this!

Diogo


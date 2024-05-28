Return-Path: <linux-kernel+bounces-191815-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F36C38D1492
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 08:39:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF53B2848AC
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 06:39:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E282067A0D;
	Tue, 28 May 2024 06:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mSeR1nlh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3052961FC5;
	Tue, 28 May 2024 06:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716878348; cv=none; b=m/erA5/tFBe5E7GCvO0nRNqo2/xRG+7uKLcKlBDySs8UZceW9tWm5QfNKgoapBtxVq/JviLtE7Z5UAGGozqQI1JHyjFaghFsRkY4IC2Ihf1ocw+FVm1/U1XL36NnKR1ckrC0udgQ3aSkds++7ZuUixoYpPpmvE+u1F7YmRGTfdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716878348; c=relaxed/simple;
	bh=VkdZMYTCXMSLhZPqLH1TyS3EUm8lbMlPJHzJkuruHMU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SGR2iUGiJCEBQp4wlkz3kbLvMevTedfMIIFz+GXJjNYR1/n0njCWZsbLr3zVKchrrrJbXQm+01WNF5GI7gRyW3ODUhWpqGW83/kFfOL25bFII4O0l8JOqGj05fIbYS3mxja0rPzzEcCHlX/cVDJhrPAZYJl82Vjapd/7kaFmXL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mSeR1nlh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7F72C3277B;
	Tue, 28 May 2024 06:39:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716878347;
	bh=VkdZMYTCXMSLhZPqLH1TyS3EUm8lbMlPJHzJkuruHMU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mSeR1nlhvUsxjiQ/74xFH+7oZSlKzb8VPRUiZKQOO8KyCS/J0/KYByTTiPrrsrbra
	 XLDc8Ud1VoYvXKfR9hzI11P5louQvEdV+r2mk1w/lgmuUDbS9yvICY9gAZ6k6wcnEB
	 rx2TU+VTj7oASRxrpHn3XRMtl9JTSzeYqWepqddDlgwJQ206kBeiYl+4HFDjfrch4g
	 RRQ9pdg7oh9tXq4NzUxSBmeCtJhW3v/r31Gj4ZHyfIa95fMUZ6dOxVNATWH1MdJJ+f
	 qSt6+Dx0vFKZP+B1fExGgDI3M5MjrEuG3usXA1DfEnpiIuymFBPE7GJdjihrhl554F
	 0zZPzGQ44ZzeQ==
Date: Tue, 28 May 2024 06:39:03 +0000
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc: Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>,
	Benson Leung <bleung@chromium.org>, Lee Jones <lee@kernel.org>,
	Guenter Roeck <groeck@chromium.org>, linux-kernel@vger.kernel.org,
	linux-hwmon@vger.kernel.org, chrome-platform@lists.linux.dev,
	Dustin Howett <dustin@howett.net>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Moritz Fischer <mdf@kernel.org>,
	Stephen Horvath <s.horvath@outlook.com.au>,
	Rajas Paranjpe <paranjperajas@gmail.com>
Subject: Re: [PATCH v3 1/3] platform/chrome: cros_ec_proto: Introduce
 cros_ec_cmd_readmem()
Message-ID: <ZlV8Bx0-FOYeeTO7@google.com>
References: <20240527-cros_ec-hwmon-v3-0-e5cd5ab5ba37@weissschuh.net>
 <20240527-cros_ec-hwmon-v3-1-e5cd5ab5ba37@weissschuh.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240527-cros_ec-hwmon-v3-1-e5cd5ab5ba37@weissschuh.net>

On Mon, May 27, 2024 at 10:58:31PM +0200, Thomas Weißschuh wrote:
> +/**
> + * cros_ec_cmd_readmem - Read from EC memory.
> + *
> + * @ec_dev: EC device
> + * @offset: Is within EC_LPC_ADDR_MEMMAP region.
> + * @size: Number of bytes to read. zero means "read a string" (including
> + *        the trailing '\0').

The behavior is cros_ec_lpc_readmem() only but not for cros_ec_cmd().


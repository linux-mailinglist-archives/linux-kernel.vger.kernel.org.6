Return-Path: <linux-kernel+bounces-576257-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACDEDA70CD6
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 23:27:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E19D3BB42C
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 22:26:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAC3E26A098;
	Tue, 25 Mar 2025 22:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Vi7sb70J"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A74F2269D16
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 22:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742941604; cv=none; b=QoKy/7nLE0Nv/pTlsF5oBfH2o5E72vx10g2r2rWoO7dAcroIn9vEiGvKvXJKJmg91/Eypb+mouxyKPWefks4t/uUdZ9+JunuNqI8zTppaD8nXzsJj+xdqLLV76s7bihRmV2zkQQT8AdmxHNsUX0DAwnlIjHAbMR6FIXvwqdQvpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742941604; c=relaxed/simple;
	bh=Ax/xgb3TsFCNXd+hqnMtNKg6gGOsr2N5FRf66cIOIgg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KNrXec2KsPBvGGI3o0XDdPqkDttgq4CodSZBBpHG9i/aRNg2z5nZaAPs1G1ymm+YK5tI+JVwiUH1jfG2qg5BfvtpSiVA6qj3syBgmQQgSEpkbQcmg+Dyj65exQYl9nnOfs3u6f40r87JGdqB31xBj1BsRUHiaBZJdzS1K5cKIUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Vi7sb70J; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2260c915749so83710875ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 15:26:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1742941602; x=1743546402; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ax/xgb3TsFCNXd+hqnMtNKg6gGOsr2N5FRf66cIOIgg=;
        b=Vi7sb70JtuukLn5QGDZk04k5Cnb/LmkT+4Bcd5F5LF6Ue7BmnVPKXComjR0tj04gIw
         iukAnQ2ki9J5FupWsM0WhPvw8VqRm+G3jEzYb3m9eoX/n7T1x2gFGdT7qLzq+ZDRafqB
         34LDoKzaA2fwQXL5FtT8v5Tvy8wLsQO75Qw2g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742941602; x=1743546402;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ax/xgb3TsFCNXd+hqnMtNKg6gGOsr2N5FRf66cIOIgg=;
        b=QtTj2vLatyxdADZq34uBVXf9+qG7aHGpEUQOG0JZzYxNgJntO55a9c91LcoWFbM0S6
         pkwnsA5Lmg0JUDEGoEX9gpl2psHDIW1nQSov/p/gkiu/y6dz/vSDm1nW7GhKkxsdElEp
         uvuIypcxXkhRoILABIBknQX0Hsy5vgChzYS0nMx36ApMuRXD0f6UN6SRYA/G/IsOgjMA
         UtClpqrEaqUe7lfWf/fTahg1vcxLmUQrVoKWVnVWyArOOs42ipR9SqjQO4TVmwhz0A9f
         EJoid0pbFZJ47wfJy2UkoLx8lQzpreME/Vn5YfR8mMOJ4XxQJuiTY1dNcTKnA8g89CaN
         0ndA==
X-Forwarded-Encrypted: i=1; AJvYcCVgpbYpoLVCG44f+kL+acqAaA39iQaJD596O1ND2el80HrDTUmS42Gd2JV/OQ/G4AuOXXIlnF4pQuu4dCI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbxGsrpv8gS6xTsfwp2eeef/auXkux09/c8NNnPpaTXns1JAux
	snIzxFU91G/mYC45sa+uaCfSKv+gIxNzXMdVonJ+i0lz4dqvMiLdfsnbbowBsQ==
X-Gm-Gg: ASbGncvpAPFl0KAi+62yKPFNfVfviS44XW8ECMJOLcwVrsUOppJGozJ42dVB0WAu38M
	RXsJs9QvawqmXdrnHkjnznLCuF6UaFhtvRbzyPsJjV3GRnQtZgyju2yC0adJ18Edv4XH4mXmoSU
	nsi/GhSLyd68dpAG02Ent0C45hDB1gJmBRyWXfZPt8JU+iUoC551jT6Q++UIGfJ0ss9384Wwi2N
	lyKr6NBdxWWBKeOahL6k88FkbhtNAKLwbxdI2w0102Y5UbfYJgdMiDHM/FDKe7paThh1tWzOHlB
	uFeTdHyaCzEH90fZRhY9iHNNqHkrYYwmITkEOF73h9fuyf7XhS5q5jRaSNM/XQHQbQ7CtO7z/NZ
	YxtT38cc=
X-Google-Smtp-Source: AGHT+IHVHlRkM1Xo1gijBPKRyHa63UrZO0+fcBb9I1JM7qtE52PfSIfTdRLQC0cXlJNB8zkMo6XFeQ==
X-Received: by 2002:a17:903:3285:b0:223:5ca1:3b0b with SMTP id d9443c01a7336-22780e122c6mr238387615ad.40.1742941601896;
        Tue, 25 Mar 2025 15:26:41 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e14:7:b885:47c3:6268:77fb])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-22780f39d48sm96249485ad.37.2025.03.25.15.26.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Mar 2025 15:26:41 -0700 (PDT)
Date: Tue, 25 Mar 2025 15:26:40 -0700
From: Brian Norris <briannorris@chromium.org>
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Francesco Dolcini <francesco@dolcini.it>,
	Johannes Berg <johannes.berg@intel.com>,
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	David Lin <yu-hao.lin@nxp.com>, kernel@pengutronix.de,
	Francesco Dolcini <francesco.dolcini@toradex.com>
Subject: Re: [PATCH wireless-next v5 00/10] mwifiex: cleanups
Message-ID: <Z-MtoOCLX2_1GztI@google.com>
References: <20250324-mwifiex-cleanup-1-v5-0-1128a2be02af@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250324-mwifiex-cleanup-1-v5-0-1128a2be02af@pengutronix.de>

On Mon, Mar 24, 2025 at 02:24:01PM +0100, Sascha Hauer wrote:
> This contains several cleanup patches for the mwifiex driver. I dropped
> the MAC address fixing patch this time as it needs more discussion, but
> the remaining patches sent here are nearly unchanged from v1 and should
> be good to go.

Thanks! For patches 1-9:

Acked-by: Brian Norris <briannorris@chromium.org>

I had some issues with patch 10.

If you respin before Johannes applies any of these, feel free to carry
my Acked-by.

Brian


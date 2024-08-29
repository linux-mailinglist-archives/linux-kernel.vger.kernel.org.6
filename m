Return-Path: <linux-kernel+bounces-307452-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DAE16964DBF
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 20:36:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8FFC82851D5
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 18:36:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17AF61B8EB2;
	Thu, 29 Aug 2024 18:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P2ndHGDZ"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0440A1B8E99;
	Thu, 29 Aug 2024 18:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724956569; cv=none; b=hg1uOoF1Tgr6CbqeQZ5afmOcoxTRylFf1DqBgLN3uQgz6JmSvyWEz0pZI1zblrP2OHb5oGPn1A3nZNDmIpYLOFTEPCk83oWp0RUpwunqQj96tO4gVydxBSxhIwBwpT9rpW6SIANp1F73FCjjlhPVRYwKHUJaBqtdD90iiHBlnuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724956569; c=relaxed/simple;
	bh=50U0Ldk2GyjhBcu0IZAOOUUJeCmfS84ma7ygxuspn4I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KY0IV18bKGI/V1TXN0MFSCgSe8XgMKK/4I/9ldUkOEKkvt933ORRKT9Vg5aZbt0Y90P11TZz031Oas/in/rchwgJLpQy1DUOb0oMcfthsMC4BwDwCYVQ2p96WtlXWuIK60c7oSWj/kgw6vr15Sgi31Eok3bQdwYrRIQZrdHDF6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P2ndHGDZ; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-202508cb8ebso6392855ad.3;
        Thu, 29 Aug 2024 11:36:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724956567; x=1725561367; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EhEN+/lQMR+6A/QUfu5yADp8zJ8yCwjiahUH8HJbcPQ=;
        b=P2ndHGDZmqjDyOiyjiDeAjW1g5HXRzqJuH3IWfK4SOIG1+ih1VyMu7OjI4LoDxiddO
         Pmkh4FGxJ5IjLh/eKZ/R9ooAcgh5QiqefEQxV9QGgSzpIRK7Nhorb+G1iejYXi9ZIUR+
         J38lozOqYFYwLYeSyaoKiqp7x+YqSd+0PrTLEm9AwOHx2shHPq9bpqO281zAQKbNS20N
         tYL8v8HTkv/ueLE1Ahs33GqHftWRQgrFPvWkkIZdm/qlgCovSXkK43v4FLnMT+IbgGXz
         i17WVqHLOJopSpQaooYnxrpXa4490xtf1IzaAvqGVGvxua+SV8p9fw2dMBXSZ5jZg5I+
         jBFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724956567; x=1725561367;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EhEN+/lQMR+6A/QUfu5yADp8zJ8yCwjiahUH8HJbcPQ=;
        b=EP+OzCbNSH3IMRJ1NXqyI95rLQjoKCHHQzUDcVgZS4CMSLLgz9Sysy7vTu05cUv/TV
         zSHYm1aDSMbbcRwH7nMPODjlDs1hPGX3zlF+kwqAgO0jXY4fW78q/VgDHsuaEMA9zYfo
         hhxyYGbRkAOSXhjmgyOpox7RzhBcSQs9FgA080f4MijM/vMCc9LCbnHnyUOefyeE2oeA
         fPfwhrnp5o3JPFNfcltQEJMRH0o+BRcpCkeAmOMPIDrBFnRvMcuSwt09P7oD54nIIyaw
         v3QFWkNYXIaZ85ftR254bbdXWcVyUecqt63MuMgKKRAdusu9+KsJMEBA5GtYOJm5X88M
         Q6Vw==
X-Forwarded-Encrypted: i=1; AJvYcCUp/mSy2NGeYRPHLpfZOCbgTI4p3bjviEcL7gU9QOZL/u5LMSFxM6ZgNwQxuEU/T0ry1u1nh3gRizZK@vger.kernel.org, AJvYcCVrXxTInWMEVix2vF2nRTa4Sq3MPPx/ZVQ2dPkg6s4nDpOvaDIk7gmnOZp9qfjxTp9+C5kJgxZufKhpQcoy@vger.kernel.org, AJvYcCWGh/r0tgNs+pC6dg+j0JvkDiNXlYPACYSsU8p1IUZnTBfdAgqUlaI1hpZ6fsuIpjB4DcbHRZQrQB7zgso=@vger.kernel.org
X-Gm-Message-State: AOJu0YwApr3GxR6SVDZ8oPRPvC+yun9zUTxA8Oj9In2m3rj8yALB55cr
	v5Z/1+kbQDplMXUcDEC0sp+t2s6s6MbNI7mVUd+tVoFbQAgP62Hc
X-Google-Smtp-Source: AGHT+IHWzU3Wj0Uup6ibq4cAiXQjW0BnB1E1XOmUrUPvgeDtr87FCdNK7YY9yJHVARFVT1j7SFAe3Q==
X-Received: by 2002:a17:902:da91:b0:203:a114:ce16 with SMTP id d9443c01a7336-2050c34fd82mr45603905ad.4.1724956566974;
        Thu, 29 Aug 2024 11:36:06 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:2ed6:5fae:d35c:9c2d])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20515544239sm14518455ad.182.2024.08.29.11.36.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2024 11:36:06 -0700 (PDT)
Date: Thu, 29 Aug 2024 11:36:03 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: utsav.agarwal@analog.com
Cc: Michael Hennerich <michael.hennerich@analog.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	linux-input@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Arturs Artamonovs <arturs.artamonovs@analog.com>,
	Vasileios Bimpikas <vasileios.bimpikas@analog.com>,
	Oliver Gaskell <oliver.gaskell@analog.com>,
	Conor Dooley <conor.dooley@microchip.com>
Subject: Re: [PATCH RESEND v11 0/3] adp5588-keys: Support for dedicated gpio
 operation
Message-ID: <ZtC_kx1lty1jeKH8@google.com>
References: <20240826-adp5588_gpio_support-v11-0-3e5ac2bd31b7@analog.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240826-adp5588_gpio_support-v11-0-3e5ac2bd31b7@analog.com>

On Mon, Aug 26, 2024 at 06:22:00PM +0100, Utsav Agarwal via B4 Relay wrote:
> Current state of the driver for the ADP5588/87 only allows partial
> I/O to be used as GPIO. This support was previously present as a
> separate gpio driver, which was dropped with the commit
> 5ddc896088b0 ("gpio: gpio-adp5588: drop the driver") since the
> functionality was deemed to have been merged with adp5588-keys.
> 
> This series of patches re-enables this support by allowing the driver to
> relax the requirement for registering a keymap and enable pure GPIO
> operation.
> 
> Signed-off-by: Utsav Agarwal <utsav.agarwal@analog.com>

Applied the series after squashing in additional changes discussed in
patch #2, thank you.

-- 
Dmitry


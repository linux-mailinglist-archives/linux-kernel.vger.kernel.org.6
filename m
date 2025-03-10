Return-Path: <linux-kernel+bounces-553752-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F2D0A58E72
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 09:43:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A0A6C169E1E
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 08:43:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 488AF224221;
	Mon, 10 Mar 2025 08:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nE4Tg2nm"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36FFB2222DF;
	Mon, 10 Mar 2025 08:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741596212; cv=none; b=qB9fPUZjktE7xtkEbhXhdpY/Xih2nYlk+33tVv8RMcD24QbLt0GBMlGS/0OZ1oJoAlLn/sZwRQM+dhaJcuvO2VgDJfY/BmvEWG5I/ubMz5sgCTjS21mnWoDazg48ym//fLCUuOavZGB2C8DXutzECLN8UvSYGLdUDGVbwWYLD1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741596212; c=relaxed/simple;
	bh=/BivDYoevo1hDOR0bLJpieM2WQ/xqr60RO17moNB6Rw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i+3iYIALtCyiFf9LgteGA7NtZnuD+kB4gKITpoKPo08pgUZPwm3bJf0e1PToPge6MyxT4J2sdAFzZc8do14L7Xu6KyLtZr10/iODyznTr+G2ZlETKq69m2Thfj+pODnSDHYvSRBYGbv6X79r1rXSQyaM6w3gXywL1py8Rqj2Cso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nE4Tg2nm; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-abf615d5f31so772966166b.2;
        Mon, 10 Mar 2025 01:43:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741596209; x=1742201009; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/BivDYoevo1hDOR0bLJpieM2WQ/xqr60RO17moNB6Rw=;
        b=nE4Tg2nmKu/7tOimKNkgWDkmXPCPYHfTTZX4vdSj6za8Xvo3fkrKlNsvn2ik2LSypE
         gLwDKIX/e51KajgsJ+YFEHas0baAeRJzzzZLZStoOyXJ6xvvXrWXSo1GF1aXxu+LvjNV
         pbXDZ9YiGIP0I2sSENeA2Av3gniwVgqhsJ9QbcR+VT3g9iUhOqASPO2W4JwgFR++agua
         GGX/svZwUhc49nYvkQq459oFA2o9USioxHsHycXs4UoLHDVsID4vFUY5HHxp2efG9rnz
         vnYEGEZsx7okYPulXw6wBRofRZqASgFa2jG9ppTeDC0NP2zSiUjH5A7rkSYrn1GUNq5v
         CYiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741596209; x=1742201009;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/BivDYoevo1hDOR0bLJpieM2WQ/xqr60RO17moNB6Rw=;
        b=M2oRhxs6bpsQJry9ZFIN8SuBnvO5dZmSHgSP4e5ksjw8ecjBao6l5RTyeSD2InSpgt
         DcOhEdsRBbr4EjCB8p7wx0fDcJRizM5/VpospVoSriLO1hcMV1xQxx+tnqg33RLgsw5V
         6wg6M36+XtgHhsTZmK034JfGYHXkkc1YxjbwkdNBkDwPkt6b31JnToI6G0f1PYUDsHsS
         2XCncfA6und3pyFiaS2R9Rgrtf5WKBe7pJ0Hh8porJm9diOZIdVorgcSXsqIeUaeu+Ib
         AtSxQTIB+cZIqMV7JU7/nw3xUZxFZHjgBXQ6Vm5UlmAlyv66o44ubh/JwV7dnKzsu2oI
         CnIg==
X-Forwarded-Encrypted: i=1; AJvYcCXSv/O6k79Ad7mHA2GW+OPx0koaKsQun60wh988arn+qX/SlKlIUTfeaUOWTAMB2VsEuGp8hYpxv0hWiO4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZ7QeunldycuZwa+UsoUAsg2wN2AHeHl1unpctnDY88KURfXxd
	XqfH0K+E90Al0uSp8yj155FrCOnjN3npF+0Ym8nMsEg/jPkEc+edQmsqQA==
X-Gm-Gg: ASbGnct+9/hwElmYtfzed+oqmAiQLIgO3LX7KONuO0kYwUZIrD9TYeqQ6lDBXBBEekf
	BzoEDpC9txfyX9w/oEiQ5DySHOAUXutFDU0iD2HBv4+R8TDFjXHNCnPwc87ApwW++ldS1HV5n2x
	pbll4Nnwsb17qjSSQNxGrGvAU0X6NsC60GHF+F4MthXNCmSvbDalzOOJHtFfoYwBjhcc60nkanr
	fDsTxKE1Pn/Kkb2/dMOMTSt4Vfpdjkq2zKzLxsqg1iG/9WnpIsZxQtwyfW1cnUnuwORdqRlKMr/
	VfQSin3sdFTJaz2GIZo1PV8L/0pDahZEVwP0/FfnJwb3wmxpY9Qra2JTKGrI8xutr2/P/CMJ
X-Google-Smtp-Source: AGHT+IH7/bI2aACIoTPWFeR5j493MEl8gNyQRhWay+OkFeYwTl3pkOAIv8Hm1z6Hea04Xx/HY6ZJ9A==
X-Received: by 2002:a17:906:c03:b0:ac2:b73:db4b with SMTP id a640c23a62f3a-ac2525ba768mr1338855266b.4.1741596209206;
        Mon, 10 Mar 2025 01:43:29 -0700 (PDT)
Received: from foxbook (adts246.neoplus.adsl.tpnet.pl. [79.185.230.246])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac251a5492asm597964866b.28.2025.03.10.01.43.28
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 10 Mar 2025 01:43:28 -0700 (PDT)
Date: Mon, 10 Mar 2025 09:43:26 +0100
From: Michal Pecio <michal.pecio@gmail.com>
To: Mathias Nyman <mathias.nyman@intel.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: usb: xhci: Don't change the status of stalled TDs on failed
 Stop EP
Message-ID: <20250310094326.0b97a7ae@foxbook>
In-Reply-To: <20250310093934.7d688648@foxbook>
References: <20250310093605.2b3d0425@foxbook>
	<20250310093934.7d688648@foxbook>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Sorry for this one, missing [PATCH] tag in the subject.
I resent it corectly.


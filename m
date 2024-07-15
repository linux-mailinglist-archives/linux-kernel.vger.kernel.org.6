Return-Path: <linux-kernel+bounces-252391-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EA4B931282
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 12:44:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 580301C226BA
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 10:44:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55E3F1891AD;
	Mon, 15 Jul 2024 10:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cCJQdAdx"
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B84C8188CD2
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 10:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721040252; cv=none; b=qEFAEeos/NKRfzPhMKyGfpZ3jcJVgOnw4dFsfTjpEwJWc5sJ+egSKm+qI4nDQXpZboO/jCxt911uePYT56HUclr0/RjYW80yzhpjs2j11IjKG08FSXzVeVBoHOoKra6q+N5d2kg9G0/nK6L2bTvF915NWhZa/G7/lkZ5O+CVBJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721040252; c=relaxed/simple;
	bh=ArjFpvyZSZjnJ0EBwp7II7TtY5rAXouqIJMsKyh7dpA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Sef0SvgR45zOccSHCw0XEIXKqKRoU7Ll75xO99YkEHsdSNvrH+nam2RpuhGJOZHO5uylOByNMt37sZnbRdrEUDO4MRaOeXofq5oVlJXaCy+DYuTH/QYTCtCREWAsSV1zBkhqoh/+hi28ECRe6ishLCzyYBcIzpflkCCSI9V2XBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=cCJQdAdx; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2eea7e2b0e6so54593841fa.3
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 03:44:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721040248; x=1721645048; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=u6DOZ74q6LaS+OZDxCfdEKnLwse8S4I+GqgO+t/odvM=;
        b=cCJQdAdxBz7M5xnQQTZj/RW4pea84TWQcr/M/uWkc+MoQtEMy9IxWjav8nK0bdvC9g
         JZQ+Am+NoxSXRuc5XSIDZPUT3/KbQGNgOSuRbXHulJdOjWk4CkF0ScbCRi8PecmSdVK4
         ZZPmIXwx6ZZmqDhzl+62SvOAomRgGmlqt8LDDtQ88LXzPNAPJuLoBHUsAcYTC8hgwQNr
         NDgfcJ4SOBWo4+Z0gm2QJKb+MAUeSqrZXugeb+RHkheOTQla7G6NOZoEQNkQxDYA1ViW
         tAi+EHIbE3LOTAasJ+oh5y7tqD07/2CDqKVzgib37BHoJq2zf64007GydDjvywcQortV
         N6KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721040248; x=1721645048;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u6DOZ74q6LaS+OZDxCfdEKnLwse8S4I+GqgO+t/odvM=;
        b=qeabdisivzYbV0q0fDIuJ4yHyv5/Ywfda4QYVQs8qjH8dEHO+TLPk1lDAuo3mJA8nL
         5pq88Z0P6mwLgJtuV7xfYmTJMD/92H9jL4X3/JpsNoqEQlYG/NdC96QY0pQH36bq/iww
         /mw2CsYclow9ZDIrM5X4sqclajLpnJfQ/fh/f9whoWU9ZsxoziRrSp2ncrn/E7SnKDqJ
         vcC7/qGCoO89QXaErt6sM5PG5mZbPot6isZeSbwGiKNqEKKNWpdglHbjMphoPV7V/rvP
         SJRliwHStib+Yol113flo34iD0pWuEOyTCL2/0zuiWlVkVDtboBf4ND9sMgfXyR6tOlE
         ixMQ==
X-Forwarded-Encrypted: i=1; AJvYcCWD4g9m281aEXklXGb0vAhahtDlNmEd9+OEXW5jLGFkKyRrATvt1ScNJiP4h6W1hRtVou2qupjp5BDuZOs00HI69DHN2WJHNIWJMq+p
X-Gm-Message-State: AOJu0Yyl27+MgsQbk7LaQocpFQLwbpEAZMix2h6FHEzd+Qz2DiexoCeF
	/5xy7lWQZd6dLi8tAsyBE1IcZPofKLfOqzcVJ1w6lhzjQxcPGGV3loyoexHup/UGkmytaDKaUG+
	Xmks0ag==
X-Google-Smtp-Source: AGHT+IGnyG/Ll9H6oeJ1EFHxhpSIWM36luDTN8GTUj1UNcKQxukVJP29d+tdlNljt20MhCCO1QXm6w==
X-Received: by 2002:a05:651c:1a08:b0:2ec:1a8b:c377 with SMTP id 38308e7fff4ca-2eeb30b4cbemr141866201fa.5.1721040247851;
        Mon, 15 Jul 2024 03:44:07 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyybrhy-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2eee18bf096sm8128601fa.61.2024.07.15.03.44.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jul 2024 03:44:07 -0700 (PDT)
Date: Mon, 15 Jul 2024 13:44:05 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Chen Ni <nichen@iscas.ac.cn>
Cc: heikki.krogerus@linux.intel.com, gregkh@linuxfoundation.org, 
	neil.armstrong@linaro.org, johan+linaro@kernel.org, quic_kriskura@quicinc.com, 
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: typec: ucsi: glink: Remove unnecessary semicolon
Message-ID: <txweguq75ghx6aqxkllvurfiituyki7skfgkiq6t4wk6xbgjxw@foigeiebnrzm>
References: <20240715073947.4028319-1-nichen@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240715073947.4028319-1-nichen@iscas.ac.cn>

On Mon, Jul 15, 2024 at 03:39:47PM GMT, Chen Ni wrote:
> Remove unnecessary semicolon at the end of the switch statement.
> This is detected by coccinelle.
> 
> Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
> ---
>  drivers/usb/typec/ucsi/ucsi_glink.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry


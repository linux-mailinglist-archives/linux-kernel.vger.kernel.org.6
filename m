Return-Path: <linux-kernel+bounces-215618-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C33DF9094F8
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jun 2024 02:10:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 278E9B213AD
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jun 2024 00:10:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51A241C2E;
	Sat, 15 Jun 2024 00:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="p3iX5pcc"
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BC61624
	for <linux-kernel@vger.kernel.org>; Sat, 15 Jun 2024 00:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718410245; cv=none; b=KQ/pa2i4gb32E14/vR6vYtNC05Ei2H43gFVLhl5bmZmW8xkx00jbLtqvKkBMjhxYAE+keORIKZQ9vFdSlxypm+t5reGAlmIIc7tCzjMa2tXXOEQPhGFeEi2HUf0PWiF/q7hQvCEH1WxpGK/OGLEtJ+8pWH9JJv5krnEdfScpBWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718410245; c=relaxed/simple;
	bh=gNewejaBAdSyW6TmuZ4lHfjXg+C8jYnOyd0Gqj1kBkQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oyLgIaDSj5W/tQqTM0HTDLhG1rvhZxmEo/KTYP8zUBMBWC0o6w2VSiOKkfsPqpcyZm8Jvt/vkDmvzyu6AOV5ZvRpgMFy+Bly676t555ZNxm6DEYJMvje54IuaHjHjr5u80La2h4vxcJCfOxJJe1GmFvhi2e+2nimqoOpNiNr6vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=p3iX5pcc; arc=none smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-25837a78858so1081575fac.2
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 17:10:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1718410243; x=1719015043; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IDFKg2giSlNRp2CWnI6wzIZGjcEuH3CutRdpX5N8j6g=;
        b=p3iX5pcciietJf8MyQs5x5zoqEMz/q2yy7lid8CdVWiVelJjom+PPTA1MPnxmztpv1
         LbfXbwtYiiWdN5SWzVqsEe8UrS8JJ3Z6Zh0Pzv+bPEm3hoxkPRWwVMbe8D2runXP3FfG
         bnfyryj20kXv4yN83Acdt5R+0fM/TCnUhWXX5yGY7pYaXgLhdOGv+NJcL89ljdHFS975
         AXHLISu+fcUy2RrL6Ci6zga1w/cEPdI8rZTZcLLjrvwBLNfXFfAt188NYJq4aIRxR7BT
         asHjiiw78MFI8Z5Xynk/uwrZSnUkruXyvR+pu6G+OPU/Rk2LIvp8dldoxc5kj6TQf9Kg
         55Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718410243; x=1719015043;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IDFKg2giSlNRp2CWnI6wzIZGjcEuH3CutRdpX5N8j6g=;
        b=E0Zq3B9XGZqzvVIyfih3PlKCICe1W1LlvrCC+MThSCxeigCy5bB58lFPimtDERWYds
         vUPmboWO7DsSXrnVMt2dgT3fjJ1IfkTclwv5yNVrBBldaSNJ+CKIY8UZ7T9Q0GEmxu/1
         lMDzRLv4IZYnl0GXhmOjKAda2Y1KpZz5BhGCv+PnqZuCyzpun6NC3DP7zzciSzFopZPG
         ljzIvX/NjA7ixFV9Jd4Enqryuo2uggUB0J5ERFy+U1EEml42s6isrPaC7kDakZcZKzQ9
         iHiK0UMwLrE+NMDctOtv98ik6KqylhpUXcrL6eFyfTsFR9phJnoLYQITzs41OTxbs/ZB
         WENQ==
X-Gm-Message-State: AOJu0YwDJj8FG+TcxpNB8VVIhruQlpapyoW6BuHV9ZaWje5J4gTGvYN8
	yXTf/BTBJexoSjbvv/tVPDV3GWR1SLj6c7cwBnB8duMpCGIwSp5wHeuNw8hkW1w=
X-Google-Smtp-Source: AGHT+IETiLeYvMfLS5qJj9lv2YNeygiz2aZ7N7GNkbFdmRrbP/g2iRj/7hvSY6Q5nrBEuc1N17ZyFw==
X-Received: by 2002:a05:6870:f145:b0:258:37f4:755c with SMTP id 586e51a60fabf-25842b0cfa0mr4379647fac.46.1718410243257;
        Fri, 14 Jun 2024 17:10:43 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-705cd498aeesm3574633b3a.23.2024.06.14.17.10.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jun 2024 17:10:42 -0700 (PDT)
Date: Fri, 14 Jun 2024 17:10:41 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Omer Shpigelman <oshpigelman@habana.ai>
Cc: linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
 netdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 ogabbay@kernel.org, zyehudai@habana.ai
Subject: Re: [PATCH 09/15] net: hbl_en: add habanalabs Ethernet driver
Message-ID: <20240614171041.7b880232@hermes.local>
In-Reply-To: <20240613082208.1439968-10-oshpigelman@habana.ai>
References: <20240613082208.1439968-1-oshpigelman@habana.ai>
	<20240613082208.1439968-10-oshpigelman@habana.ai>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 13 Jun 2024 11:22:02 +0300
Omer Shpigelman <oshpigelman@habana.ai> wrote:

> +static int hbl_en_ports_reopen(struct hbl_aux_dev *aux_dev)
> +{
> +	struct hbl_en_device *hdev = aux_dev->priv;
> +	struct hbl_en_port *port;
> +	int rc = 0, i;
> +
> +	for (i = 0; i < hdev->max_num_of_ports; i++) {
> +		if (!(hdev->ports_mask & BIT(i)))
> +			continue;
> +
> +		port = &hdev->ports[i];
> +
> +		/* It could be that the port was shutdown by 'ip link set down' and there is no need
> +		 * in reopening it.
> +		 * Since we mark the ports as in reset even if they are disabled, we clear the flag
> +		 * here anyway.
> +		 * See hbl_en_ports_stop_prepare() for more info.
> +		 */
> +		if (!netif_running(port->ndev)) {
> +			atomic_set(&port->in_reset, 0);
> +			continue;
> +		}
> +

Rather than duplicating network device state in your own flags, it would be better to use
existing infrastructure. Read Documentation/networking/operstates.rst

Then you could also get rid of the kludge timer stuff in hbl_en_close().



Return-Path: <linux-kernel+bounces-182817-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 302898C9060
	for <lists+linux-kernel@lfdr.de>; Sat, 18 May 2024 12:14:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C325D1F21B79
	for <lists+linux-kernel@lfdr.de>; Sat, 18 May 2024 10:14:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1B1D266AB;
	Sat, 18 May 2024 10:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="lGxkYnWM"
Received: from mail2.andi.de1.cc (vmd64148.contaboserver.net [161.97.139.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABB8C1773A;
	Sat, 18 May 2024 10:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=161.97.139.27
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716027229; cv=none; b=L3l2N8+kEjZossdXAthfgFzNQjErpqFWUW+BzhcVNYMixpGNou5RZ4CItqr6FP+mHW9HzNXyRoWN6p2Qg75bsYwz7/ECs1cvTg04US7cXGwnZVBT4Uu0jSgJgJbWEQraJVesBUv/uDTtzUpnkoogAuaQFqC6bBdbP6JC/wS7tNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716027229; c=relaxed/simple;
	bh=JEEGJe7P7TsOOE2g5iqa8BKS6lSw1rmKWvrEVpgafAk=;
	h=Date:From:To:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RbkVrUhyvVC3P864oZQVUcJuvbCpMtLqszJpFqL3NqCvu6ziac1fO5xuWVRiYbHXb56oxkxjaiX9U4liawbQgiXsZCWiLghGdBBHYqD1TRoAVPL5ctXubs3fH3isHVtz5T1KMKIQrHufxbOtEwDoCkRM97P2w9CinRxbbn2RZsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kemnade.info; spf=pass smtp.mailfrom=kemnade.info; dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b=lGxkYnWM; arc=none smtp.client-ip=161.97.139.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kemnade.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kemnade.info
Received: from mail.andi.de1.cc ([2a02:c205:3004:2154::1])
	by mail2.andi.de1.cc with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <andreas@kemnade.info>)
	id 1s8GZ6-006VvV-0f;
	Sat, 18 May 2024 11:41:21 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kemnade.info; s=20220719; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:References:In-Reply-To:Message-ID:Subject:To:From:Date:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=GZdz7DcQuZNUr0jvTXCmmPFf3gkI4Rtn8V9Cae9sto0=; b=lGxkYnWMYZypqxVrxAGzVjAiff
	Kjo2o2LPO6tHTj1Oklu3HEz2yTvA23u9m/QBmLKX19/P11xwu4r7KBsnqnHHQprUHybYC0HR0Riwu
	5vdd5O00bpSO4Vj16/gMC/OG8uu1zgA0sVzzEcd93e+1ZSPi0BkCC1L8Va0hCsZnrSwI7uwgsYmEA
	/EDOf5MZZFSIP2kUzCvYxWvn7AEn0Z0atDbQVRAznvulNo209aun+PKhbP9d7wEKOnbw7UB0EqpV3
	W/F2XBoAPR/17liJxkpsDqOwDVp1Pj5/EsSl8Va00Mu0qBXTUXNqRyxlOl4Upqis987gA7gM41iK8
	O1F0n2+Q==;
Received: from p200300c20737c2001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:c2:737:c200:1a3d:a2ff:febf:d33a] helo=aktux)
	by mail.andi.de1.cc with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <andreas@kemnade.info>)
	id 1s8GZ4-001KiF-0X;
	Sat, 18 May 2024 11:41:19 +0200
Date: Sat, 18 May 2024 11:41:17 +0200
From: Andreas Kemnade <andreas@kemnade.info>
To: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
 festevam@gmail.com, marex@denx.de, leoyang.li@nxp.com,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 2/2] ARM: dts: imx: Add Kobo Clara HD rev b
Message-ID: <20240518114117.54d7aa75@aktux>
In-Reply-To: <20240504215344.861327-3-andreas@kemnade.info>
References: <20240504215344.861327-1-andreas@kemnade.info>
	<20240504215344.861327-3-andreas@kemnade.info>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat,  4 May 2024 23:53:44 +0200
Andreas Kemnade <andreas@kemnade.info> wrote:

> There is a variation of the Kobo Clara HD containing a PMIC with different
> default settings for the regulators in the OTP and therefore also
> regulators wired up in a different way, so add a proper devicetree for it
> to avoid some magic smoke.
> 
[...]
> +&cpu0 {
> +	arm-supply = <&dcdc5_reg>;
> +	soc-supply = <&dcdc2_reg>;
> +};
> +
Vendor devicetree has also this snippet for that revision:

       cpus {
                cpu0: cpu@0 {
                        operating-points = <    /* Core2_1V3_ARM */
                                /* kHz    uV */
                                996000  1062500
                                792000  1062500
                                396000  1062500
                                198000  975000
                        >;
                        fsl,soc-operating-points = <    /* Core2_1V3_SOC */
                                /* ARM kHz      SOC-PU uV */
                                996000          987500
                                792000          987500
                                396000          987500
                                198000          900000
                        >;
                };

        };

Apparently we run into https://gitlab.com/postmarketOS/pmaports/-/issues/2811
but I cannot find any documentation an alternative voltage ranges for that SoC
(i.MX6SLL). So not all 6SLLs are created equal? At least we do not mix up 1.XV regulators
with 3.3 regulators now, that is more healthy.

Regards,
Andreas


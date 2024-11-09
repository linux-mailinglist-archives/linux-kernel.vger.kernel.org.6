Return-Path: <linux-kernel+bounces-403041-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CB1499C3012
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Nov 2024 00:32:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D83611C20C1F
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Nov 2024 23:31:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 240C31A0BE3;
	Sat,  9 Nov 2024 23:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kruces-com.20230601.gappssmtp.com header.i=@kruces-com.20230601.gappssmtp.com header.b="dRWCy2Ew"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A239C146A73
	for <linux-kernel@vger.kernel.org>; Sat,  9 Nov 2024 23:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731195113; cv=none; b=QF3NUiS/GUMonkiwszBXwtTC6RJST7Zk/Ztzos5PuoDTEC1bqFWTfV0Ee9nWSxZwuz5p0L5seODLrfMq5Qo0G1S62CM2aSqmy6zXHuHzmXznWHCODbDFEVcVhwZCkwv3N8PXW5iPQ5iRMCqUg5pOtbIgsgntTXwfHdAltw/KlfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731195113; c=relaxed/simple;
	bh=pymxjzEm6Lhvwp4mUDTpE9i10Lufs3nfZipuuthsxww=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:To:From:Subject:
	 References:In-Reply-To; b=j/ZJ5i+Jf1wzPMftD6VtBuzMRjD62ttBjdV2JUELtu3BYcN9FZaRUbq/x6qBF1H2u1rvJ7gVHYBtLo3QRUQ+TPIQLB3j68jFH8juDeoCdMjW/5U1rB4WKhoC9yt7AshvoZRT0rTgHeH2VdqVL+m3b5CLlzPzObDcXpoDN6iyu3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kruces.com; spf=pass smtp.mailfrom=kruces.com; dkim=pass (2048-bit key) header.d=kruces-com.20230601.gappssmtp.com header.i=@kruces-com.20230601.gappssmtp.com header.b=dRWCy2Ew; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kruces.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kruces.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4316cce103dso41488395e9.3
        for <linux-kernel@vger.kernel.org>; Sat, 09 Nov 2024 15:31:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kruces-com.20230601.gappssmtp.com; s=20230601; t=1731195110; x=1731799910; darn=vger.kernel.org;
        h=in-reply-to:references:subject:from:to:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xXefZuNiUme2LqYfCd3jj+JYJ6NFPXXl60F1M5w4QPE=;
        b=dRWCy2EwEtBiFZRy20wqlW7tbsPzhAvKieWNhvIHRPd0fbZmxwDPqSja9UmKTvULRp
         mAlf/Q8B9JLWTWEVyDcoFfW5sMVAYVQc9Smniw2xJH9+UFzoJEofjRPpiw0yTYtzAQr8
         NIDEq7yp/Cwsj3esFghT1Mz/nvPth8deFjIyoDRdGBxcXhEaTx+ZxYmKORv15loXQZYG
         vNefdC+VcbxfZ77ZnHYD4AonkdVqZmvtNxXV81BJ5+vBmi7ONbdVBSYVatHDmfr4WGVh
         Z8viVjFcZqfXSXc2x4g1f/upaYwIud93mFQLxZdog8GhhsWmROXNz5tRGNbEKV0Nywl+
         9uHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731195110; x=1731799910;
        h=in-reply-to:references:subject:from:to:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=xXefZuNiUme2LqYfCd3jj+JYJ6NFPXXl60F1M5w4QPE=;
        b=lNRG7906Xk/ALhUksWGE0XMZIARMIZIZ5jIijhFqM18tyW5mDKksWhLUk2p5BA6NVj
         RkBMlBZsGAFt3J2+1hLimVWgJDNVbTP9xp0R3GQWAgs2kDW2BURreL8phGuqTehfkO2o
         gt8yuhnMBJS/uLVDOvLN3fIbdt3kjgPnH9VVIkxKx9T9LKFd4q74MfOMqMOMYlGFX5Sz
         YSVVSwpNBytoDwMLzMQmnnfvlXxbrqwck8yrtU6J4fOIzntuHqE1s9OPjjEiZcXpXZqE
         aolC5pALAnI4ObOkgTDCdYBoNKh1CU2fLGizJSUGZOJI5ZbFtXnPQpsTZwKs7sybmE6e
         tTBw==
X-Forwarded-Encrypted: i=1; AJvYcCXOSENbnnpxMb3cGzQzAHebhCB/3mW1guRsXMKIexELR9M/QTgOz1Vt8sgOKCXcji47sP/nhjOOpp66o7w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzjq55kFigtlpA2YZSUX+7rtZo118ZDaTwFLhuAGyIBxGxFj+2e
	OvVH66ZE/Z+WWjbjhRiihFH94NUcACqq9/pRyeq0EDFQ7fG9nX7bHtPqRudl7ZE=
X-Google-Smtp-Source: AGHT+IGrTxPd6AbPrewOKapTMXeIDNB6k1NOzYVtEtw766khzfIJoPkxkQ5IvxY0rEmc3mXiJHIsJA==
X-Received: by 2002:a05:6000:1acc:b0:381:eb8a:b81b with SMTP id ffacd0b85a97d-381f1872402mr8821444f8f.33.1731195109725;
        Sat, 09 Nov 2024 15:31:49 -0800 (PST)
Received: from localhost (89-23-255-189.ip4.fiberby.net. [89.23.255.189])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9ee0e2f3cdsm418712966b.185.2024.11.09.15.31.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 09 Nov 2024 15:31:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 10 Nov 2024 00:31:48 +0100
Message-Id: <D5I1G5K85QLC.FP6NF7M20KXQ@kruces.com>
Cc: "Bjorn Andersson" <andersson@kernel.org>, "Rob Herring"
 <robh@kernel.org>, "Krzysztof Kozlowski" <krzk+dt@kernel.org>, "Conor
 Dooley" <conor+dt@kernel.org>, "Marijn Suijten"
 <marijn.suijten@somainline.org>, <linux-arm-msm@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Abel Vesa"
 <abel.vesa@linaro.org>, "Johan Hovold" <johan@kernel.org>
To: "Marcus Glocker" <marcus@nazgul.ch>, "Konrad Dybcio"
 <konradybcio@kernel.org>
From: "Daniel Gomez" <d@kruces.com>
Subject: Re: [PATCH v5 4/6] arm64: dts: qcom: Add UFS node
X-Mailer: aerc HEAD-434ca29
References: <p3mhtj2rp6y2ezuwpd2gu7dwx5cbckfu4s4pazcudi4j2wogtr@4yecb2bkeyms> <g5vlxrttgvfqkktlkhu4uzhtvnp3qtjcbr7l2uztapzqwhrsem@wg574xldh5ar> <cd9d5a7c-ec0b-4f0a-bac2-f747799bf295@kernel.org> <l5vwputpefdkweti56em37i5asrd3vb7pxhwlzir7webfuk3fl@afcqm3faq2gt>
In-Reply-To: <l5vwputpefdkweti56em37i5asrd3vb7pxhwlzir7webfuk3fl@afcqm3faq2gt>

On Fri Aug 30, 2024 at 7:25 PM CEST, Marcus Glocker wrote:
> On Fri, Aug 30, 2024 at 02:05:48AM +0200, Konrad Dybcio wrote:
>
>> On 17.08.2024 10:38 PM, Marcus Glocker wrote:
>> > Add the UFS Host Controller node.  This was basically copied from the
>> > arch/arm64/boot/dts/qcom/sc7180.dtsi file.
>> >
>> > Signed-off-by: Marcus Glocker <marcus@nazgul.ch>
>> > Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> > ---
>> >  arch/arm64/boot/dts/qcom/x1e80100.dtsi | 72 +++++++++++++++++++++++++=
+
>> >  1 file changed, 72 insertions(+)
>> >
>> > diff --git a/arch/arm64/boot/dts/qcom/x1e80100.dtsi=20
>> > b/arch/arm64/boot/dts/qcom/x1e80100.dtsi
>> > index 7bca5fcd7d52..9f01b3ff3737 100644
>> > --- a/arch/arm64/boot/dts/qcom/x1e80100.dtsi
>> > +++ b/arch/arm64/boot/dts/qcom/x1e80100.dtsi
>> > @@ -2878,6 +2878,78 @@ mmss_noc: interconnect@1780000 {
>> >  			#interconnect-cells =3D <2>;
>> >  		};
>> >
>> > +		ufs_mem_hc: ufs@1d84000 {
>> > +			compatible =3D "qcom,x1e80100-ufshc", "qcom,ufshc",
>> > +				     "jedec,ufs-2.0";
>> > +			reg =3D <0 0x01d84000 0 0x3000>;
>> > +			interrupts =3D <GIC_SPI 265 IRQ_TYPE_LEVEL_HIGH>;
>> > +			phys =3D <&ufs_mem_phy>;
>> > +			phy-names =3D "ufsphy";
>> > +			lanes-per-direction =3D <1>;
>> > +			#reset-cells =3D <1>;
>> > +			resets =3D <&gcc GCC_UFS_PHY_BCR>;
>> > +			reset-names =3D "rst";
>> > +
>> > +			power-domains =3D <&gcc GCC_UFS_PHY_GDSC>;
>> > +
>> > +			iommus =3D <&apps_smmu 0xa0 0x0>;
>>=20
>> Looks like this should be 0x1a0 maybe
>> > +
>> > +			clock-names =3D "core_clk",
>> > +				      "bus_aggr_clk",
>> > +				      "iface_clk",
>> > +				      "core_clk_unipro",
>> > +				      "ref_clk",
>> > +				      "tx_lane0_sync_clk",
>> > +				      "rx_lane0_sync_clk";
>> > +			clocks =3D <&gcc GCC_UFS_PHY_AXI_CLK>,
>> > +				 <&gcc GCC_AGGRE_UFS_PHY_AXI_CLK>,
>> > +				 <&gcc GCC_UFS_PHY_AHB_CLK>,
>> > +				 <&gcc GCC_UFS_PHY_UNIPRO_CORE_CLK>,
>> > +				 <&rpmhcc RPMH_CXO_CLK>,
>> > +				 <&gcc GCC_UFS_PHY_TX_SYMBOL_0_CLK>,
>> > +				 <&gcc GCC_UFS_PHY_RX_SYMBOL_0_CLK>;
>>=20
>> You also want
>>=20
>> <&gcc GCC_UFS_PHY_RX_SYMBOL_1_CLK>
>>=20
>> > +			freq-table-hz =3D <50000000 200000000>,
>> 25000000 300000000
>>=20
>> > +					<0 0>,
>> > +					<0 0>,
>> > +					<37500000 150000000>,
>> 75000000 300000000
>>=20
>> > +					<0 0>,
>> > +					<0 0>,
>> > +					<0 0>;
>> > +
>> > +			interconnects =3D <&aggre1_noc MASTER_UFS_MEM QCOM_ICC_TAG_ALWAYS
>> > +					 &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ALWAYS>,
>> > +					<&gem_noc MASTER_APPSS_PROC QCOM_ICC_TAG_ALWAYS
>> > +					 &config_noc SLAVE_UFS_MEM_CFG QCOM_ICC_TAG_ALWAYS>;
>> > +			interconnect-names =3D "ufs-ddr", "cpu-ufs";
>> > +
>> > +			qcom,ice =3D <&ice>;
>> > +
>> > +			status =3D "disabled";
>> > +		};
>> > +
>> > +		ufs_mem_phy: phy@1d87000 {
>> > +			compatible =3D "qcom,x1e80100-qmp-ufs-phy";
>> > +			reg =3D <0 0x01d87000 0 0x1000>;
>>=20
>> most definitely should be 0x01d80000 with a size of 0x2000
>>=20
>> > +			clocks =3D <&rpmhcc RPMH_CXO_CLK>,
>> > +				 <&gcc GCC_UFS_PHY_PHY_AUX_CLK>,
>> > +				 <&tcsr TCSR_UFS_PHY_CLKREF_EN>;
>> > +			clock-names =3D "ref",
>> > +				      "ref_aux",
>> > +				      "qref";
>> > +			power-domains =3D <&gcc GCC_UFS_PHY_GDSC>;
>> > +			resets =3D <&ufs_mem_hc 0>;
>> > +			reset-names =3D "ufsphy";
>> > +			#phy-cells =3D <0>;
>> > +			status =3D "disabled";
>> > +		};
>> > +
>> > +		ice: crypto@1d90000 {
>> > +			compatible =3D "qcom,x1e80100-inline-crypto-engine",
>> > +				     "qcom,inline-crypto-engine";
>> > +			reg =3D <0 0x01d90000 0 0x8000>;
>>=20
>> 0x1d88000
>>=20
>>=20
>> All this combined means you probably wrote your init sequence into some
>> free(?) register space and the one left over from the bootloader was
>> good enough :P
>>=20
>> Konrad
>
> I have not done anything special in our sub-system to boot this DTB.
> Changing the values as suggested by you also doesn't make any difference
> to me.
>
> Anyway, I think I'll give up at this point, since this process is
> getting too time consuming for me.  We'll go ahead with out downstream
> patches, which works for us so far.

Hi Marcus,

I came across this and I'd be interested in picking up the patches for test=
ing.
Is there any guide or documentation available that I could follow to boot L=
inux
on this machine using this patchset? Also, could you share where I might be=
 able
to find those downstream patches?

Thanks,
Daniel

>
> Cheers,
> Marcus



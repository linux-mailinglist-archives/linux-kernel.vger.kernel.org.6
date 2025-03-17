Return-Path: <linux-kernel+bounces-564142-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E708A64E54
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 13:15:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B61D416FA6D
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 12:14:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7944238D25;
	Mon, 17 Mar 2025 12:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="2RPg9GFa"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5718C231C8D
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 12:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742213558; cv=none; b=hiqNoRi02rE8Mx/cLDONqHpCJFNGmJPflMngeV1hZdzRpPzNXADwT7ILvo5tDvly8An9O81XDHP7+5GuVWz1FjW5+4iOfoHCoW4UEZX5zPF6G0qHIDZfRW2Gs9XF416xo+Ks0He9SxvON69MjWiHdaynaOsBH7NJSOm9MG3A9n4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742213558; c=relaxed/simple;
	bh=UgTOwub6IM8lyO1PUttTb8emd3or5wxqwiyiuHKamRY=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=K5MCfnI8KGgvuOoQ/q/FfMKwWsHIj4RbiOeVTOKMErbPJM82gefxolENdqqRTf7qZs94JI9+PQ8W7yyLVFGzItlxFdKlZe7lg5Dlx/CYCEFJowgYt6tO9df5GpxXU2eHzloR9kHix8XMX/svVr0KsDk+/EuvzximknEma65E5eA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=2RPg9GFa; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5dc89df7eccso7271568a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 05:12:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1742213554; x=1742818354; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XgQI7i+glIQS/JWP7XVCA4jeAmkUf5EqjBge8pBC6Ps=;
        b=2RPg9GFaS0FW/R6a/Oa+Eu4gYRoxkw4NnGeQWu4MxAfDe2PavyxfNMnduMLbEtAjDk
         SPB88KK6PZLywylXVcIzT50aKwDoaXulbBD8ELLebkQW/t3ItciM9/PAB1//OYrFMv53
         8br3+iGWwuKPZLhCaSex2hv3vFXniTuubIcjRV5lDJcsP+LgHiDDepOwZK4fEa+8KYlH
         9CqECDXEGlmD3/AweW6PqtBYnOEhTpju/DXSXZpnPftijBvhvfyqajhVxBxe1wZ4QnV1
         uwftG7/wuUftUqtD5ilTvBnGL9jTdlJkCM3b/S5EtegIZ4/+TinRyd2+T91eKgbD5p05
         /G8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742213554; x=1742818354;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=XgQI7i+glIQS/JWP7XVCA4jeAmkUf5EqjBge8pBC6Ps=;
        b=e5FU324esPDHbb7FPdPm149bKloZetMFLGcU1zooL8ffFl5kVbH8vEgxup035WaBz2
         Nkp3iwmCz/JTzActXsI0IY8UQlaJ0K4RJ5pd5/aQrnL9XteBLIe9WFunfThp4oE0Ni36
         ykCobAwXD6wKCOdy3ZfKNKW6xqXLh16p6UMaRQpdvC7CWh+PyB7P3iYGDgHimaCLntln
         vetXx2SVNUB9QEwMnBiIzkvbyfZZeYxFDiJH31js5Y8gorMvNpGzVH75syLwUHSskMbp
         mnExsg+F95Jht4ERoQja5taO/VaKhYzdCgK3+lbnv2vWHVmO573PQdrdNqG4qwi+7W4G
         2mfw==
X-Forwarded-Encrypted: i=1; AJvYcCVAR+9G4a3E+4XyG99E9uXw2Dii4bV+qeUiXwPMQLWRiD+u1SGjgWRwrW0PH/YQOsz7zd6Cshs3VqsKnz0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQjr2IrskuoGS+Fg5LxgSGDptzsSROemcCydDfd35SBkRfXOSf
	A4xylQfkvVDJobz3ioZQIFwKOAg3ywkekz5lxP1LHr9Z3UgRMGKoT/MZfzi+OHA=
X-Gm-Gg: ASbGncvvpcYMjdbdj8FYWLgbwHDfT5NKliJ5ycwi8AagOBdIjz0h7E070Rim0MJ55Pv
	hfiRrVKrhnJjajXAdb/NKI32LqPEI2nKCUpD2VM7+XWJuW4GHp8B8+/10N08hgMrpEVgQ6DMzTf
	eR7XxAACOg/c0J0zUTMvAp/84PF9K3mXxAutchX9yIPbk+XC5XpwP/52/zGAPCpaPRnfqxesVHz
	pGI18MRVn4WwTxo/3G+wHFIO4bTUpEeZbSlsQpB9fhFjHtf7y0ydc/JnbECAdnO26NGlVDXnv5b
	RAMCnWqaHOf8g8jwkjQhwu9cFgy9nSr+wBHf/6PqT4UkZUM8rZRS5hy3gdS++BshQXGjuKdeu4J
	5fCpbHM8ocZaWeg==
X-Google-Smtp-Source: AGHT+IGkBMivzQV4mRjAFxSl5hkbzmyy3jCErKcn7Cl5GDE/j11zVkAXm1oq3i12rfExH1BTJTH/vg==
X-Received: by 2002:a05:6402:518a:b0:5e5:3643:c8b5 with SMTP id 4fb4d7f45d1cf-5e8a080aa09mr12579753a12.30.1742213554535;
        Mon, 17 Mar 2025 05:12:34 -0700 (PDT)
Received: from localhost (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e8169b0232sm6033780a12.38.2025.03.17.05.12.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Mar 2025 05:12:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 17 Mar 2025 13:12:33 +0100
Message-Id: <D8IJ5TEHREW1.2FK88ACT1JPYQ@fairphone.com>
From: "Luca Weiss" <luca.weiss@fairphone.com>
To: "Konrad Dybcio" <konrad.dybcio@oss.qualcomm.com>, "Bjorn Andersson"
 <andersson@kernel.org>, "Konrad Dybcio" <konradybcio@kernel.org>, "Rob
 Herring" <robh@kernel.org>, "Krzysztof Kozlowski" <krzk+dt@kernel.org>,
 "Conor Dooley" <conor+dt@kernel.org>
Cc: <~postmarketos/upstreaming@lists.sr.ht>, <phone-devel@vger.kernel.org>,
 "Krzysztof Kozlowski" <krzk@kernel.org>, <linux-arm-msm@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/3] arm64: dts: qcom: sm6350: Add OPP table support to
 UFSHC
X-Mailer: aerc 0.20.1-0-g2ecb8770224a
References: <20250314-sm6350-ufs-things-v1-0-3600362cc52c@fairphone.com>
 <20250314-sm6350-ufs-things-v1-2-3600362cc52c@fairphone.com>
 <cddcd851-5e8c-4202-baad-e56a09d5775a@oss.qualcomm.com>
In-Reply-To: <cddcd851-5e8c-4202-baad-e56a09d5775a@oss.qualcomm.com>

Hi Konrad,

On Fri Mar 14, 2025 at 11:08 PM CET, Konrad Dybcio wrote:
> On 3/14/25 10:17 AM, Luca Weiss wrote:
>> UFS host controller, when scaling gears, should choose appropriate
>> performance state of RPMh power domain controller along with clock
>> frequency. So let's add the OPP table support to specify both clock
>> frequency and RPMh performance states replacing the old "freq-table-hz"
>> property.
>>=20
>> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
>> ---
>
> [...]
>
>> +
>> +			ufs_opp_table: opp-table {
>> +				compatible =3D "operating-points-v2";
>> +
>> +				opp-50000000 {
>> +					opp-hz =3D /bits/ 64 <50000000>,
>> +						 /bits/ 64 <0>,
>> +						 /bits/ 64 <0>,
>> +						 /bits/ 64 <37500000>,
>
> This rate on this clk requires opp_svs (not low_svs)

Not sure where you're seeing this?

This is from my msm-4.19 tree:

gcc_ufs_phy_axi_clk_src:
    .rate_max =3D (unsigned long[VDD_NUM]) { [VDD_LOWER] =3D 50000000,
gcc_ufs_phy_unipro_core_clk_src:
    .rate_max =3D (unsigned long[VDD_NUM]) { [VDD_LOWER] =3D 37500000,
gcc_ufs_phy_ice_core_clk_src:
    .rate_max =3D (unsigned long[VDD_NUM]) { [VDD_LOWER] =3D 75000000,

[VDD_LOWER] =3D RPMH_REGULATOR_LEVEL_LOW_SVS,

My intepretation for this is we need low_svs?

Regards
Luca

>
> with that:
>
> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
>
> Konrad



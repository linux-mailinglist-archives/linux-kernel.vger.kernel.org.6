Return-Path: <linux-kernel+bounces-567849-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCF8CA68B51
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 12:23:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1793C8A0201
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 11:16:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4517A2566CF;
	Wed, 19 Mar 2025 11:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="QHEP19yA"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 354F6254844
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 11:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742382405; cv=none; b=I7ANTQwCbX424XvH8eSfF4i+xANh/0LfiMXX4AP+4DVEgOu8XNw2Ir01P6W/J2XjAPHA+qghnwqj2RLwJ3KMpjRNlJG4DnDUeHVmgmAljNbBYZci/T7qgKCE8+YHE3p/jahBOhMHH3xNvEztTrtJyv0kF30uUjntgSaBJ+QQrT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742382405; c=relaxed/simple;
	bh=+6dINfWYNledSDKrXEMCld5larCRcQ2l9XF8anqBVjc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YMK4HcAyVykTuQbVB4DZ2DdwuM+26+WVzJHtdlTsijbzqsI9urVz4+H/0G4qQkqC1prr2aDim908GhxC49YG5oLcm6hknygR+ItgZM+Wu4hZiX4Cxt2GWXmLhDZeWLbrC17qp2t9kjB/v4cLTXi7eU0u989Iua4aifvZzmZ08Ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=QHEP19yA; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52J4li2Z011973
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 11:06:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=zpsXstT/OPpXfwxen2clafNs
	aafRQUG65nkBT0J8LsY=; b=QHEP19yAAefK9EtYpTBUzF1zrikRg2tIl8LSwLsS
	743G8O6EXY9jdDTCgqz3mXxf7zJ037zHg+MaRzb+EOav9X2pCuP9+Rdk+Fa2HkRk
	4UtXGSzfGYAT88ukdMJQ5MK1WbeunhJKF13WIosb6JMVHASK1aVFEUHtBvp1vMQF
	Wd+ngZvh+XUrwUiY5lL/1lfV0WSLYfhENNKh58Z1d7Iaa1m+5npEUAACQACFLkNx
	n4QTf9EcARzc4s79RfAqYTNDw2KAJPIqZPDYeJKD9ca1UmTgaPG+fez/EDtR1YcZ
	Gv7cBK8ZM7nJzc3vBLTzVClNtMAS4e/PEX5hhaHRRplwiA==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45f010mwka-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 11:06:41 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-6e9083404b7so135196246d6.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 04:06:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742382400; x=1742987200;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zpsXstT/OPpXfwxen2clafNsaafRQUG65nkBT0J8LsY=;
        b=X/3fIAuD/bOLgy571EF46HMPJ2qHh8Imqzfbp/wJ6v+fZqM+Ml5d/8eZbISwmG8b0S
         xTs45xXuBoicb/4mOzkjUmCN7sJXjbVLmhUXNQ1qCNc1oMcPQ7rPQt8w8hiPu+OPy3X3
         pLl1ykYfqMbvsVPCsrFNc6SiAdZ5C2Hv3FtNv0YWYhJG7vmL+ja/8TshNplEuK15cmqc
         qt9YR/KguGp2ZUih5BLgKD2lWdqNYRY5AHtXu11nbgfT9Tr7spFU+bcB4P769v/AhXaB
         BH8lroOq0oUboU7fl9jWkYkaZd8XZlPdXBGGyp6uy4Pib5UBfCCX8XcONLdJGqVDLY6A
         NpeA==
X-Forwarded-Encrypted: i=1; AJvYcCXhm4YDozac87ohTPMkWTFtC5fSPgAriWCIEWjTdpuX+masKNj5ZRAqGS3namNjtuU+6JwIS6r7yyYl8zk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZw4XSSd5ecCdx4oQAApi1qxR4dim+51PadKUAhbuitU73/QGD
	DMcs6nZ2idf6O+pkMPRF+1PvQrg+vlR9IGCo/ZR5VWyIMEaaRZ9gzBJ7hl0A6Lht3nHwOBZcxgr
	tWeyvU2g2Lf9ObUw3oRjjd/qyAdGmJ+6JyYcOliVHH718S6248t9w+7gS/YmxucQ=
X-Gm-Gg: ASbGncvZ5dH2cdYxtxQJ/snn5Gb8zzuVjcOXxwe7LxXVXau6KTXwWTMD6XNjbVctuHF
	JR83WEipLJLeRmwiMx0nn1/eQe6eiU6I1XU+gwfZScJDYiiMcgnOe0juuOgeqB/2AEZj7/osbsY
	QIKU2MxqlZRXkDQdjoGSQV8N17qkBpCEUevQi26TkgcLgUSsWIME0geSar4lqU2sMWMVukvvWZz
	posD7G0lXy0SVYeLAi6s9bqE1VY3fm71/moscx2ZDz2aCs4vgDfabZ0nrYu67HV9erVZZJ3iDPO
	MaSg0Y5Hj6JBZtIa/nvBErh/KjqSKCmVPggctwbJDFlrQrAdXT0VkQ+G7NbBfoFrFcUkjPY1cI7
	/me4=
X-Received: by 2002:a05:6214:2529:b0:6eb:28e4:8516 with SMTP id 6a1803df08f44-6eb293c733amr37447816d6.33.1742382399874;
        Wed, 19 Mar 2025 04:06:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG2t0QGksJArRSWkBCYZvSyReO8b4mt3eWRfhwdfAQcyv4fEjzOnD9kov0aGqtEzwp57TDlNw==
X-Received: by 2002:a05:6214:2529:b0:6eb:28e4:8516 with SMTP id 6a1803df08f44-6eb293c733amr37447326d6.33.1742382399503;
        Wed, 19 Mar 2025 04:06:39 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-549ba88508asm1920760e87.186.2025.03.19.04.06.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 04:06:37 -0700 (PDT)
Date: Wed, 19 Mar 2025 13:06:34 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Krishna Chaitanya Chundru <quic_krichai@quicinc.com>
Cc: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        cros-qcom-dts-watchers@chromium.org, Jingoo Han <jingoohan1@gmail.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>, quic_vbadigan@quicnic.com,
        amitk@kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, jorge.ramirez@oss.qualcomm.com
Subject: Re: [PATCH v4 02/10] arm64: dts: qcom: qcs6490-rb3gen2: Add TC956x
 PCIe switch node
Message-ID: <ip7xacfkpv7gf5w3gdgrweo5z7bqxmkfmvgsjfaurk5j5ac6mp@nqccdhunhwws>
References: <20250225-qps615_v4_1-v4-0-e08633a7bdf8@oss.qualcomm.com>
 <20250225-qps615_v4_1-v4-2-e08633a7bdf8@oss.qualcomm.com>
 <kao2wccsiflgrvq7vj22cffbxeessfz5lc2o2hml54kfuv2mpn@2bf2qkdozzjq>
 <8a2bce29-95dc-53b0-0516-25a380d94532@oss.qualcomm.com>
 <CAO9ioeW6-KgRmFO93Ouhyx9uQcdaPoX3=mjpz_2SPHKiHh3RkQ@mail.gmail.com>
 <16a9ff11-70dc-22e9-bd3c-ed10bf8b4fea@quicinc.com>
 <hkm76yogjp6fjrldkyatekhg7orcd6wkc43d2e7cwzqfrdxjwh@b4f2rilmf6gh>
 <303194d4-d342-ea4c-0bb6-5f5d0297ba23@quicinc.com>
 <xkjozxbchqi6mhstqctejfk7vmwux4kdff2nyrcu5nxqzxv73z@agb7rbapsvx2>
 <f2e67746-853d-8545-133a-13452548d504@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f2e67746-853d-8545-133a-13452548d504@quicinc.com>
X-Proofpoint-ORIG-GUID: tqfPENkSNanxte3CNOWSZC55AKwbC1zR
X-Proofpoint-GUID: tqfPENkSNanxte3CNOWSZC55AKwbC1zR
X-Authority-Analysis: v=2.4 cv=G50cE8k5 c=1 sm=1 tr=0 ts=67daa541 cx=c_pps a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=Vs1iUdzkB0EA:10 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8 a=YhunDdt0IHZmoyGD5E8A:9 a=CjuIK1q_8ugA:10
 a=pJ04lnu7RYOZP9TFuWaZ:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-19_03,2025-03-19_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 lowpriorityscore=0 mlxlogscore=999 phishscore=0 adultscore=0
 impostorscore=0 spamscore=0 clxscore=1015 malwarescore=0
 priorityscore=1501 bulkscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2503190077

On Wed, Mar 19, 2025 at 04:16:33PM +0530, Krishna Chaitanya Chundru wrote:
> 
> 
> On 3/19/2025 3:51 PM, Dmitry Baryshkov wrote:
> > On Wed, Mar 19, 2025 at 03:46:00PM +0530, Krishna Chaitanya Chundru wrote:
> > > 
> > > 
> > > On 3/19/2025 3:43 PM, Dmitry Baryshkov wrote:
> > > > On Wed, Mar 19, 2025 at 09:14:22AM +0530, Krishna Chaitanya Chundru wrote:
> > > > > 
> > > > > 
> > > > > On 3/18/2025 10:30 PM, Dmitry Baryshkov wrote:
> > > > > > On Tue, 18 Mar 2025 at 18:11, Krishna Chaitanya Chundru
> > > > > > <krishna.chundru@oss.qualcomm.com> wrote:
> > > > > > > 
> > > > > > > 
> > > > > > > 
> > > > > > > On 3/17/2025 4:57 PM, Dmitry Baryshkov wrote:
> > > > > > > > On Tue, Feb 25, 2025 at 03:03:59PM +0530, Krishna Chaitanya Chundru wrote:
> > > > > > > > > Add a node for the TC956x PCIe switch, which has three downstream ports.
> > > > > > > > > Two embedded Ethernet devices are present on one of the downstream ports.
> > > > > > > > > 
> > > > > > > > > Power to the TC956x is supplied through two LDO regulators, controlled by
> > > > > > > > > two GPIOs, which are added as fixed regulators. Configure the TC956x
> > > > > > > > > through I2C.
> > > > > > > > > 
> > > > > > > > > Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
> > > > > > > > > Reviewed-by: Bjorn Andersson <andersson@kernel.org>
> > > > > > > > > Acked-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > > > > > > > > ---
> > > > > > > > >      arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts | 116 +++++++++++++++++++++++++++
> > > > > > > > >      arch/arm64/boot/dts/qcom/sc7280.dtsi         |   2 +-
> > > > > > > > >      2 files changed, 117 insertions(+), 1 deletion(-)
> > > > > > > > > 
> > > > > > > > > @@ -735,6 +760,75 @@ &pcie1_phy {
> > > > > > > > >         status = "okay";
> > > > > > > > >      };
> > > > > > > > > 
> > > > > > > > > +&pcie1_port {
> > > > > > > > > +    pcie@0,0 {
> > > > > > > > > +            compatible = "pci1179,0623", "pciclass,0604";
> > > > > > > > > +            reg = <0x10000 0x0 0x0 0x0 0x0>;
> > > > > > > > > +            #address-cells = <3>;
> > > > > > > > > +            #size-cells = <2>;
> > > > > > > > > +
> > > > > > > > > +            device_type = "pci";
> > > > > > > > > +            ranges;
> > > > > > > > > +            bus-range = <0x2 0xff>;
> > > > > > > > > +
> > > > > > > > > +            vddc-supply = <&vdd_ntn_0p9>;
> > > > > > > > > +            vdd18-supply = <&vdd_ntn_1p8>;
> > > > > > > > > +            vdd09-supply = <&vdd_ntn_0p9>;
> > > > > > > > > +            vddio1-supply = <&vdd_ntn_1p8>;
> > > > > > > > > +            vddio2-supply = <&vdd_ntn_1p8>;
> > > > > > > > > +            vddio18-supply = <&vdd_ntn_1p8>;
> > > > > > > > > +
> > > > > > > > > +            i2c-parent = <&i2c0 0x77>;
> > > > > > > > > +
> > > > > > > > > +            reset-gpios = <&pm8350c_gpios 1 GPIO_ACTIVE_LOW>;
> > > > > > > > > +
> > > > > > > > 
> > > > > > > > I think I've responded here, but I'm not sure where the message went:
> > > > > > > > please add pinctrl entry for this pin.
> > > > > > > > 
> > > > > > > Do we need to also add pinctrl property for this node and refer the
> > > > > > > pinctrl entry for this pin?
> > > > > > 
> > > > > > I think that is what I've asked for, was that not?
> > > > > Currently there is no pincntrl property defined for this.
> > > > 
> > > > Does it need to be defined separately / specially?
> > > > 
> > > yes we need to define this property now.
> > 
> > Could you please point out existing schema files defining those
> > properties?
> sorry I was not able to get which schema file you are requesting for,
> if it is tc956x it is in this series only.
> 
> What I understood from these conversation is we need to define pinctrl
> property and refer the reset gpio pin in next series. If it was wrong
> please correct me.

You claimed that pinctrl properties (there are several of those) are to
be defined in the schema for TC956x. I asked you to point out other
schema files which define those properties for the devices that use
GPIO pins.

-- 
With best wishes
Dmitry


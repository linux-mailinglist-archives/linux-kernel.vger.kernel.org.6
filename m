Return-Path: <linux-kernel+bounces-215131-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D946E908E7E
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 17:17:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF7F41C251AC
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 15:17:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68FC215E5CB;
	Fri, 14 Jun 2024 15:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="SRa3vcYz"
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24C7E17B437
	for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 15:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718378182; cv=none; b=TMNrxtF9wtuH15nsRFPkVQ31hwTfxwaQkf+CLsobX7rkbhnXa1UBAJ6oUIizHRl9ueNnBb4nTBFb2MhbfLL7r578agACI8ef1BfBHqFPsEdCqZkSQzwgPMrTXgJh93tf5P5lCzh1l7JzbzI7Fj51wqpwAxfhaSwJ/KrOV4VidgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718378182; c=relaxed/simple;
	bh=TiodcIZ8APASrNG2TNFEbGVxf//IPiuvrfkl7MhR9Ec=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O/QCekVcKJLktXNGLzDMG75oLuLoZjTGSHRC8T9SvSE2Prkmqaaq3y3LWIm+LtfIMKPCgBTahCWRgQnUIzZYfBlaUJkqBI/piOFTYYs9EQH/feWc+jRiS5jfg08wol0ODNb5fPOUPpTFHhobYpEr2jh76xNcXlIBcliFoiNmUAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=SRa3vcYz; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: radhey.shyam.pandey@amd.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1718378178;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cBFQtVI/CQ92nnAYeYybhd0YC0jo3zy4/zd2LFAyq3U=;
	b=SRa3vcYzkww+nQWyrWYMn82GPZVRyTM7j+gmVc1qeV5BFJbhyzARtTdzoiOZbjW9+xQhJ/
	ldNH3HqYVTkjjcETc6Hp6z6Mxs0g53P/xJ0oUiypAirXZWMKM/BPdSKgBqacdec/X4S46i
	84dwES5RXjvTG4OfIoEAUN48CcCI6Zc=
X-Envelope-To: laurent.pinchart@ideasonboard.com
X-Envelope-To: linux-phy@lists.infradead.org
X-Envelope-To: vkoul@kernel.org
X-Envelope-To: linux-arm-kernel@lists.infradead.org
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: michal.simek@amd.com
X-Envelope-To: kishon@kernel.org
Message-ID: <2bfa49bd-b72f-4c50-a573-5aa766dff6d9@linux.dev>
Date: Fri, 14 Jun 2024 11:16:14 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2 2/4] phy: zynqmp: Store instance instead of type
To: "Pandey, Radhey Shyam" <radhey.shyam.pandey@amd.com>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 "linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>
Cc: Vinod Koul <vkoul@kernel.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "Simek, Michal" <michal.simek@amd.com>,
 Kishon Vijay Abraham I <kishon@kernel.org>
References: <20240506170110.2874724-1-sean.anderson@linux.dev>
 <20240506170110.2874724-3-sean.anderson@linux.dev>
 <MN0PR12MB59535CC0B70185DDF8044AC5B7C22@MN0PR12MB5953.namprd12.prod.outlook.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sean Anderson <sean.anderson@linux.dev>
In-Reply-To: <MN0PR12MB59535CC0B70185DDF8044AC5B7C22@MN0PR12MB5953.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 6/14/24 02:02, Pandey, Radhey Shyam wrote:
>> -----Original Message-----
>> From: Sean Anderson <sean.anderson@linux.dev>
>> Sent: Monday, May 6, 2024 10:31 PM
>> To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>; linux-
>> phy@lists.infradead.org
>> Cc: Vinod Koul <vkoul@kernel.org>; linux-arm-kernel@lists.infradead.org;
>> linux-kernel@vger.kernel.org; Michal Simek <michal.simek@amd.com>;
>> Kishon Vijay Abraham I <kishon@kernel.org>; Sean Anderson
>> <sean.anderson@linux.dev>
>> Subject: [PATCH v2 2/4] phy: zynqmp: Store instance instead of type
>> 
>> The phy "type" is just the combination of protocol and instance, and is
>> never used apart from that. Store the instance directly, instead of
>> converting to a type first. No functional change intended.
>> 
>> Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
>> ---
>> 
>> Changes in v2:
>> - Expand the icm_matrix comment
>> 
>>  drivers/phy/xilinx/phy-zynqmp.c | 115 +++++++++-----------------------
>>  1 file changed, 31 insertions(+), 84 deletions(-)
>> 
>> diff --git a/drivers/phy/xilinx/phy-zynqmp.c b/drivers/phy/xilinx/phy-
>> zynqmp.c
>> index 5a434382356c..5a8f81bbeb8d 100644
>> --- a/drivers/phy/xilinx/phy-zynqmp.c
>> +++ b/drivers/phy/xilinx/phy-zynqmp.c
>> @@ -147,22 +147,6 @@
>>  /* Total number of controllers */
>>  #define CONTROLLERS_PER_LANE		5
>> 
>> -/* Protocol Type parameters */
>> -#define XPSGTR_TYPE_USB0		0  /* USB controller 0 */
>> -#define XPSGTR_TYPE_USB1		1  /* USB controller 1 */
>> -#define XPSGTR_TYPE_SATA_0		2  /* SATA controller lane 0 */
>> -#define XPSGTR_TYPE_SATA_1		3  /* SATA controller lane 1 */
>> -#define XPSGTR_TYPE_PCIE_0		4  /* PCIe controller lane 0 */
>> -#define XPSGTR_TYPE_PCIE_1		5  /* PCIe controller lane 1 */
>> -#define XPSGTR_TYPE_PCIE_2		6  /* PCIe controller lane 2 */
>> -#define XPSGTR_TYPE_PCIE_3		7  /* PCIe controller lane 3 */
>> -#define XPSGTR_TYPE_DP_0		8  /* Display Port controller lane 0 */
>> -#define XPSGTR_TYPE_DP_1		9  /* Display Port controller lane 1 */
>> -#define XPSGTR_TYPE_SGMII0		10 /* Ethernet SGMII controller 0 */
>> -#define XPSGTR_TYPE_SGMII1		11 /* Ethernet SGMII controller 1 */
>> -#define XPSGTR_TYPE_SGMII2		12 /* Ethernet SGMII controller 2 */
>> -#define XPSGTR_TYPE_SGMII3		13 /* Ethernet SGMII controller 3 */
>> -
>>  /* Timeout values */
>>  #define TIMEOUT_US			1000
>> 
>> @@ -185,7 +169,8 @@ struct xpsgtr_ssc {
>>  /**
>>   * struct xpsgtr_phy - representation of a lane
>>   * @phy: pointer to the kernel PHY device
>> - * @type: controller which uses this lane
>> + * @instance: instance of the protocol type (such as the lane within a
>> + *            protocol, or the USB/Ethernet controller)
>>   * @lane: lane number
>>   * @protocol: protocol in which the lane operates
>>   * @skip_phy_init: skip phy_init() if true
>> @@ -194,7 +179,7 @@ struct xpsgtr_ssc {
>>   */
>>  struct xpsgtr_phy {
>>  	struct phy *phy;
>> -	u8 type;
>> +	u8 instance;
>>  	u8 lane;
>>  	u8 protocol;
>>  	bool skip_phy_init;
>> @@ -331,8 +316,8 @@ static int xpsgtr_wait_pll_lock(struct phy *phy)
>> 
>>  	if (ret == -ETIMEDOUT)
>>  		dev_err(gtr_dev->dev,
>> -			"lane %u (type %u, protocol %u): PLL lock timeout\n",
>> -			gtr_phy->lane, gtr_phy->type, gtr_phy->protocol);
>> +			"lane %u (protocol %u, instance %u): PLL lock
>> timeout\n",
>> +			gtr_phy->lane, gtr_phy->protocol, gtr_phy-
>> >instance);
>> 
>>  	return ret;
>>  }
>> @@ -647,8 +632,7 @@ static int xpsgtr_phy_power_on(struct phy *phy)
>>  	 * cumulating waits for both lanes. The user is expected to initialize
>>  	 * lane 0 last.
>>  	 */
>> -	if (gtr_phy->protocol != ICM_PROTOCOL_DP ||
>> -	    gtr_phy->type == XPSGTR_TYPE_DP_0)
>> +	if (gtr_phy->protocol != ICM_PROTOCOL_DP || !gtr_phy->instance)
>>  		ret = xpsgtr_wait_pll_lock(phy);
>> 
>>  	return ret;
>> @@ -678,73 +662,33 @@ static const struct phy_ops xpsgtr_phyops = {
>>   * OF Xlate Support
>>   */
>> 
>> -/* Set the lane type and protocol based on the PHY type and instance
>> number. */
>> +/* Set the lane protocol and instance based on the PHY type and instance
>> number. */
>>  static int xpsgtr_set_lane_type(struct xpsgtr_phy *gtr_phy, u8 phy_type,
>>  				unsigned int phy_instance)
>>  {
>>  	unsigned int num_phy_types;
>> -	const int *phy_types;
>> 
>>  	switch (phy_type) {
>> -	case PHY_TYPE_SATA: {
>> -		static const int types[] = {
>> -			XPSGTR_TYPE_SATA_0,
>> -			XPSGTR_TYPE_SATA_1,
>> -		};
>> -
>> -		phy_types = types;
>> -		num_phy_types = ARRAY_SIZE(types);
>> +	case PHY_TYPE_SATA:
>> +		num_phy_types = 2;
>>  		gtr_phy->protocol = ICM_PROTOCOL_SATA;
>>  		break;
>> -	}
>> -	case PHY_TYPE_USB3: {
>> -		static const int types[] = {
>> -			XPSGTR_TYPE_USB0,
>> -			XPSGTR_TYPE_USB1,
>> -		};
>> -
>> -		phy_types = types;
>> -		num_phy_types = ARRAY_SIZE(types);
>> +	case PHY_TYPE_USB3:
>> +		num_phy_types = 2;
>>  		gtr_phy->protocol = ICM_PROTOCOL_USB;
>>  		break;
>> -	}
>> -	case PHY_TYPE_DP: {
>> -		static const int types[] = {
>> -			XPSGTR_TYPE_DP_0,
>> -			XPSGTR_TYPE_DP_1,
>> -		};
>> -
>> -		phy_types = types;
>> -		num_phy_types = ARRAY_SIZE(types);
>> +	case PHY_TYPE_DP:
>> +		num_phy_types = 2;
>>  		gtr_phy->protocol = ICM_PROTOCOL_DP;
>>  		break;
>> -	}
>> -	case PHY_TYPE_PCIE: {
>> -		static const int types[] = {
>> -			XPSGTR_TYPE_PCIE_0,
>> -			XPSGTR_TYPE_PCIE_1,
>> -			XPSGTR_TYPE_PCIE_2,
>> -			XPSGTR_TYPE_PCIE_3,
>> -		};
>> -
>> -		phy_types = types;
>> -		num_phy_types = ARRAY_SIZE(types);
>> +	case PHY_TYPE_PCIE:
>> +		num_phy_types = 4;
>>  		gtr_phy->protocol = ICM_PROTOCOL_PCIE;
>>  		break;
>> -	}
>> -	case PHY_TYPE_SGMII: {
>> -		static const int types[] = {
>> -			XPSGTR_TYPE_SGMII0,
>> -			XPSGTR_TYPE_SGMII1,
>> -			XPSGTR_TYPE_SGMII2,
>> -			XPSGTR_TYPE_SGMII3,
>> -		};
>> -
>> -		phy_types = types;
>> -		num_phy_types = ARRAY_SIZE(types);
>> +	case PHY_TYPE_SGMII:
>> +		num_phy_types = 4;
>>  		gtr_phy->protocol = ICM_PROTOCOL_SGMII;
>>  		break;
>> -	}
>>  	default:
>>  		return -EINVAL;
>>  	}
>> @@ -752,22 +696,25 @@ static int xpsgtr_set_lane_type(struct xpsgtr_phy
>> *gtr_phy, u8 phy_type,
>>  	if (phy_instance >= num_phy_types)
>>  		return -EINVAL;
>> 
>> -	gtr_phy->type = phy_types[phy_instance];
>> +	gtr_phy->instance = phy_instance;
>>  	return 0;
>>  }
>> 
>>  /*
>> - * Valid combinations of controllers and lanes (Interconnect Matrix).
>> + * Valid combinations of controllers and lanes (Interconnect Matrix). Each
>> + * "instance" represents one controller for a lane. For PCIe and DP, the
>> + * "instance" is the logical lane in the link. For SATA, USB, and SGMII,
>> + * the instance is the index of the controller.
>> + *
>> + * This information is only used to validate the devicetree reference, and is
>> + * not used when programming the hardware.
>>   */
>>  static const unsigned int
>> icm_matrix[NUM_LANES][CONTROLLERS_PER_LANE] = {
>> -	{ XPSGTR_TYPE_PCIE_0, XPSGTR_TYPE_SATA_0, XPSGTR_TYPE_USB0,
>> -		XPSGTR_TYPE_DP_1, XPSGTR_TYPE_SGMII0 },
>> -	{ XPSGTR_TYPE_PCIE_1, XPSGTR_TYPE_SATA_1, XPSGTR_TYPE_USB0,
>> -		XPSGTR_TYPE_DP_0, XPSGTR_TYPE_SGMII1 },
>> -	{ XPSGTR_TYPE_PCIE_2, XPSGTR_TYPE_SATA_0, XPSGTR_TYPE_USB0,
>> -		XPSGTR_TYPE_DP_1, XPSGTR_TYPE_SGMII2 },
>> -	{ XPSGTR_TYPE_PCIE_3, XPSGTR_TYPE_SATA_1, XPSGTR_TYPE_USB1,
>> -		XPSGTR_TYPE_DP_0, XPSGTR_TYPE_SGMII3 }
>> +	/* PCIe, SATA, USB, DP, SGMII */
>> +	{ 0, 0, 0, 1, 0 }, /* Lane 0 */
>> +	{ 1, 1, 0, 0, 1 }, /* Lane 1 */
>> +	{ 2, 0, 0, 1, 2 }, /* Lane 2 */
>> +	{ 3, 1, 1, 0, 3 }, /* Lane 3 */
>>  };
> 
> Feel this change reduces readability and introduce magic values
> for icm_matrix and num_phy_types. At times decoding these 
> numbers can be hard. 

> Can we retain deriving num_phy_types from ARRAY_SIZE(types);
> and also defines for ICM matrix?

There is no point. The value of e.g. XPSGTR_TYPE_PCIE_3 would be 3.
The value of XPSGTR_TYPE_SATA_1 would be 1. The names are already
given by the structure of the matrix.

--Sean

>> 
>>  /* Translate OF phandle and args to PHY instance. */
>> @@ -822,7 +769,7 @@ static struct phy *xpsgtr_xlate(struct device *dev,
>>  	 * is allowed to operate on the lane.
>>  	 */
>>  	for (i = 0; i < CONTROLLERS_PER_LANE; i++) {
>> -		if (icm_matrix[phy_lane][i] == gtr_phy->type)
>> +		if (icm_matrix[phy_lane][i] == gtr_phy->instance)
>>  			return gtr_phy->phy;
>>  	}
>> 
>> --
>> 2.35.1.1320.gc452695387.dirty
> 



Return-Path: <linux-kernel+bounces-572445-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D9563A6CA5C
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Mar 2025 14:36:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 49DC71B64BBB
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Mar 2025 13:36:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 052A020C028;
	Sat, 22 Mar 2025 13:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=inadvantage.onmicrosoft.com header.i=@inadvantage.onmicrosoft.com header.b="CIHUBRO6"
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2119.outbound.protection.outlook.com [40.107.95.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C35E800;
	Sat, 22 Mar 2025 13:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.119
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742650595; cv=fail; b=ELOQ0cHoqowiubhgS0w9zDzYiAUr/m8OZ9YFzk7akPvgbNBkg1IZZiRTUn2RAApFUojxDRCCzQYylytkywCxsNgqj+geC+zOOus4FhUGox+SBZfyrNAd6k3rN6hr/r4U8sXG1tt8OIygJpHCK5Kr0pu3yjeOci4w4ZahQk+iVaY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742650595; c=relaxed/simple;
	bh=YsY0pfg6qsUkG9fgOsLnp9It4Sc2PoxSxm5NJKorxDs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=bGUzEc5mBOL6XGCv+rAamMcY1B0cUEMWr1Kr7pcfGsAq/BntflNz5s8+pGtyLJmNZbAPlAvNAzuIzvHwdcPHBmYOOlEQ0DgMkNIGfYDDDVZ/kcAWAKlylSJNu84VcNrCKkOznbfXMRQhAVzr7UqGkImYkwYBxiT07AlpSua48vs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=in-advantage.com; spf=pass smtp.mailfrom=in-advantage.com; dkim=pass (1024-bit key) header.d=inadvantage.onmicrosoft.com header.i=@inadvantage.onmicrosoft.com header.b=CIHUBRO6; arc=fail smtp.client-ip=40.107.95.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=in-advantage.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=in-advantage.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nS6x8iRcwycusFIrCFM/HeUKW/OKX5GjqRmD8yHVBRNQ48pK0ZMK4s0YLGxTelIJ34AWQ2/o5hThyWyLwo7Hb89p+lXg2IYYt7YtlAEloSrPqUs8us+AwqhFWPtxJsAPvV4/p35rKgQSkvrs4qPH/MmlHQZKjdV7rhQVdL3oolojKSatDGEalJuKunr47wO1jZJ1r1yDoAFhqzxd1O0555d3AvofXmPZwpmxKdOIm/ZcTyr0Iz07+Wyl10Ug4CAaKaDZyt6Nn48ARQXKNFL455GXwcpElD2o3QA4K+B3MdlilcL1XPKQOkEDH5iVnExzhvt0SGBjwqddcQb2yKhYfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I1AFSR34cgO/bxhEIgsrb56I2KLx0o4fTDYBZhbtgQc=;
 b=h5CP3v8gSRmUA0Puquol5uDC0JO26PDzj7bs9yQ/kknNrEwSwA51Mb35dFQ7sc4rCGp1zFUJo1rAasclk3aPpt+Ujs5vXY/OD6eX+aFQqsdu7+8By8IL0wlUrTNYYfysAHQjOzHn0LWEjsu5Gede/WdQtzsicUjs7GBSfOlOoxNB+1DJW0awRZHWgchHxHAlLz5EKe1Q7TCyrqiTfwlSlHkBqUrFYUmv+2csIkm7P8C75pquNxpQftSXLh2IQGAZm6cmGNrjN7SJjtc6+iLoMGyYVV+ZjfSnEZrGaydhW7U/fH3fKtrLcw1esHZZfIjncLCU7fmVP30Dv8VjSLt3Zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=in-advantage.com; dmarc=pass action=none
 header.from=in-advantage.com; dkim=pass header.d=in-advantage.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=inadvantage.onmicrosoft.com; s=selector2-inadvantage-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I1AFSR34cgO/bxhEIgsrb56I2KLx0o4fTDYBZhbtgQc=;
 b=CIHUBRO6tms/HXnLcqOhYH9PMwWMrhNSgb93aASLoyh9Av9UxfMaucsqT2op1aax9d5GlS8eF2E/h0FT1LzqCgrjOizRhBFSovyyxoq3NK8JOTNOq9NKBz9Ao20/52TCn4xmBPySqunY1DpaNpWbev2/7tSVLR0g9o7cjtDpTgs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=in-advantage.com;
Received: from DS0PR10MB6974.namprd10.prod.outlook.com (2603:10b6:8:148::12)
 by IA1PR10MB6195.namprd10.prod.outlook.com (2603:10b6:208:3a5::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Sat, 22 Mar
 2025 13:36:30 +0000
Received: from DS0PR10MB6974.namprd10.prod.outlook.com
 ([fe80::7603:d234:e4ab:3fea]) by DS0PR10MB6974.namprd10.prod.outlook.com
 ([fe80::7603:d234:e4ab:3fea%6]) with mapi id 15.20.8534.036; Sat, 22 Mar 2025
 13:36:29 +0000
Date: Sat, 22 Mar 2025 08:36:27 -0500
From: Colin Foster <colin.foster@in-advantage.com>
To: Rasmus Villemoes <ravi@prevas.dk>
Cc: Lee Jones <lee@kernel.org>, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	Felix Blix Everberg <felix.blix@prevas.dk>
Subject: Re: [PATCH 3/8] mfd: ocelot: rework SPI (re-)initialization after
 chip reset
Message-ID: <Z9682y2Z_BUUjg2e@colin-ia-desktop>
References: <20250319123058.452202-1-ravi@prevas.dk>
 <20250319123058.452202-4-ravi@prevas.dk>
 <Z9tASE2-adiEUT-3@colin-ia-desktop>
 <87v7s4rlwu.fsf@prevas.dk>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87v7s4rlwu.fsf@prevas.dk>
X-ClientProxiedBy: CH0PR03CA0261.namprd03.prod.outlook.com
 (2603:10b6:610:e5::26) To DS0PR10MB6974.namprd10.prod.outlook.com
 (2603:10b6:8:148::12)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6974:EE_|IA1PR10MB6195:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ed65f35-61ee-481c-5dde-08dd69468d3f
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9Fs9VzIHNpyNYbqp04CMTVgfc9TQuXLlKtGc6BQRcANFDQ6UoKa65+qH3BpU?=
 =?us-ascii?Q?Y5n8xjQoHslsMAbIYEIQzynbDSjwaPXq/HDvoxzj48lAsbFxXu6O2or67aaX?=
 =?us-ascii?Q?7emxYLKcfcsywueOj/QI29yokOmwS+4DvzyYglOw8Gm6G5Oi8mJCc2frngX+?=
 =?us-ascii?Q?MTnFKMmr+C6crHztsGwtKv/prB2wPxXtlF24kMk2U58r70KOx4yipQlOz772?=
 =?us-ascii?Q?KYCQdz+WeprnH73aG1xEwypou+yesUZOjhD9KqnjZAVDwXDR7lrlBAYMMuIy?=
 =?us-ascii?Q?PdpnVcxsE0fjghyIGZ6QKNvk+DZC/SjeaPrm95rBYud0uSRmas/k20CHwJ07?=
 =?us-ascii?Q?ubFDHoTGHJB2F6nguKAazNLuAmzBwpWQF0T4jx9O6DTywTfIeoc1uHeJrkXn?=
 =?us-ascii?Q?kyHQF2CqEQIVuB0MLWo6dHTJpt0jUSsjLKunBvU2YXq8z+2fLQno23Ux53B5?=
 =?us-ascii?Q?npgoJrXvuLfkRBdgV/uf/H7NlK9IF+zVB4BYzsQlrmtGtn3TX+G0J5QYE7gN?=
 =?us-ascii?Q?vfJKPDLNCbHffUYQ0F1VRFxlSfTpoUDGKG2an3PiGwDVLQZ0CO/kv2VAso3c?=
 =?us-ascii?Q?VYO7jrieQp1SkQa5DBXBcHbX9ys7o9jDZ9R4bdrIICPPqMbhqTEqokqFPjWY?=
 =?us-ascii?Q?x+sXw34hdmrzTwbRK+Z9KJUbh6ZyonyC0NScjVTAKw+B+o0Abvpo2GB0H9/B?=
 =?us-ascii?Q?8v32lNcCjA20kdl5VAxZrOu0yvR1V+L7UVSly1fMNbL28P8jP3fLWfkHyzX5?=
 =?us-ascii?Q?ewzL5WerPCoTL2uCwyhTTThRD3DlRBY90u1RHBr3011sRYlKi6S1S67e4ZFS?=
 =?us-ascii?Q?X5G0dzTck3B9VVDMoLo4dim5NbuBhiL8Gadq/+gjbh1M6DSCA6OmtOrtBbMT?=
 =?us-ascii?Q?LXbfcL/BYDuW3zWtZgVA/2ivZG6SDSxl+QxCtZyF5V9Vcqj1OcvkKe13h9z2?=
 =?us-ascii?Q?gvRKDbVc5cNlux8Owy3pHn0Zs6d1B1/2IH+KcQOzD1bg4dE2S44jN8DbdusA?=
 =?us-ascii?Q?20xZPpVyKkiLQvZqDUjgziZ2AJMQmHJ6aPYIPd6mVzjWbUQjAH3OIRaPi4O5?=
 =?us-ascii?Q?icHXvQ9pBm5E29HNQTJH2YSfEHfnj2aR5ZHAgnJMKup9d5MFaW+Ld8uK3UvX?=
 =?us-ascii?Q?hCbGHwfouOP30G4mhWlbUwgcO8ZrC1iu/T8MCu97/kZOfamcWc571eSue+yd?=
 =?us-ascii?Q?c+WbPZhkYtW03clAQ3I7eN51Mo3uXo+pOMYA6fYXmIq2KH7ZdllWQl+0KIp7?=
 =?us-ascii?Q?bxTfYNubVk7CrCb7l2K3xjsDxCm7BhX7wgYutg6yY9T6zPdOdvCPMCM/2+OC?=
 =?us-ascii?Q?WhNfRE6/l6QBia8yyFDNjV8iuLxJz+PjFSf+rx0rR3Hh2Txowfpu/oGwiR2X?=
 =?us-ascii?Q?STNnNjekWQisnRSZheIF4mqCzFiF?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6974.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?D2K+jgNSm2vrpggKgoCUOGz7KeaTcGcviBNykd4vHqKqD3q0kYR/kfK3YkZI?=
 =?us-ascii?Q?99WE8gZr5alXMf6EV+d0ZyovYwV7vuAKfOmWHLLMGMcqNP5bk1Kr+aE77RW+?=
 =?us-ascii?Q?e7nV/duOvbuknhjBssRKCxP1LBbxEWOhl9SkKWf4oztspyqgBtd9my6Uej5m?=
 =?us-ascii?Q?O8OiSUUCcXsCjFHie+nR/n9DYEjYO+u+OX0s5i2Ll0RC1TF4mqkLGVOLpJJC?=
 =?us-ascii?Q?d2cQIFRXq6Zh9tzVj1w7K0qbmoM3/6G+pBws72bYhCFcEg5SiGTtkbI3HJm5?=
 =?us-ascii?Q?ba9sqSQZ6XHeGa0+WzCLMAiNIEqnxoJ0HG2zTgW/tWQWZRolYyx6TU/PBhRo?=
 =?us-ascii?Q?3A9Zq4i+F70cs/iKcesVj7WPVsD5mDCbx2Eh9VCIan8kU1ylrHx6WFJuT+2v?=
 =?us-ascii?Q?HL7WxkSLCTjBHmQSvhksT6HU8IWSBAUbhxu5oH7j3oTS4idLaDIqWiD3i1lT?=
 =?us-ascii?Q?ijUmoLsAL62NVKBAj1v+8b56pTi9DxKBIl4piUwxg6p3yi9zBTR3y2vovVel?=
 =?us-ascii?Q?lNM6RE7pbRx+wSGIjxv1WAWqzuNE31AoyqAyBkcyjdlWqAiakbGuFfhLZQf4?=
 =?us-ascii?Q?RyKlwsjDvQgWIzolgrEFmtCepQcznokjg9d3UWtCV9acxsoeMtho5KNUMqJZ?=
 =?us-ascii?Q?ew7lQ52t7FoQXmMGJGW182vE2xRx5ItnlLPOZMK5oUlmivgED0B1wg3dl2xH?=
 =?us-ascii?Q?HOwAZVJZnGEPYrnSlEDLVOy2/hV3yDf/rA53ysGq7WKtZk1gvazHUOR+whJ9?=
 =?us-ascii?Q?KWNaeD5KfelW1Ku899g48QfLxrJdKLVGmnvE04S4VLL18khb8b6zF9mhzz0b?=
 =?us-ascii?Q?1zh8Roft/cL+tOl91FdANvBFlZr6KVRgb6QKSmjD1CKMT+SeTSyEEAJULYMR?=
 =?us-ascii?Q?/pvYlR2/fXW6VPJ4bDmNA4l1wVvb7fGYTsqVKhAjR7cKrx4Xd3GlBRm98GiT?=
 =?us-ascii?Q?hMVDqAtyHV2/iViE/G18GDN40cRSHDmRENLdQZ51FolwdS3azCivw+D4ALJ4?=
 =?us-ascii?Q?q1FmdYgukPsv06QO2MAD3ZzOfYdGEbmpeHhJKpfVpi5Otsh3unk8AVjT+4zo?=
 =?us-ascii?Q?pDeChwdelXo7RT/NDlFsFfWXejwgh+0bX0WLiBUCbmvo150i/vVMJ57bbukQ?=
 =?us-ascii?Q?31W1LQasbbbZI8Ptgn1VXZ+/cjKdBsJQz6MeUS0UovqHOulG/TOzBPEsSyEh?=
 =?us-ascii?Q?h2SV+5AR7D78ceyomqU1+nqU1TEf7LlnzNBXb7P00yxybPG2hS9nNdFN1jfH?=
 =?us-ascii?Q?MsK3QBrO4uWKPgWrFXBnDFstbKegUmFZX1fcEC90mhIcD8bNGxmqbhnhJdjw?=
 =?us-ascii?Q?Qx1fC3SWkIRJPrzzuPSjvOl/bmOnVZQkgV32EQ9QClwzLGK21SQe7FSQVzw6?=
 =?us-ascii?Q?3Fffz2s8sAkftB+G9JvU3HLSr3hzaSWgNu6w+pjQke8ZNNWrJooPaXZfOwVb?=
 =?us-ascii?Q?yXnt9y+8pwt8U22s0NBB1ehx0K77CAiXh9yoJQ3r8vY6onR5oWjy1k4LOmct?=
 =?us-ascii?Q?eqgut9Nruh0BVo4s4hrPrYftsVUdUXxUp+GKCJE6+Q76uejkSvc4B1a68KNm?=
 =?us-ascii?Q?Cz+Y/A96knKEtqQm+N0Hdyv4jiLzihMH/xjDYIECrUKjhdUpWc9m05Lnp62I?=
 =?us-ascii?Q?bfExZojz8znOtSRxKwFI3F4=3D?=
X-OriginatorOrg: in-advantage.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ed65f35-61ee-481c-5dde-08dd69468d3f
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6974.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2025 13:36:29.6949
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 48e842ca-fbd8-4633-a79d-0c955a7d3aae
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CH8o+SxApqLeiLBpEVPaAVyIADA69OD+GWvta9H2v+fGjI1fU4/wJ07X4P3OFwvdQ959W+dP5cG0XpQrFPHMVPhJMYgYknqyg/SDJ7zQQeA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6195

On Thu, Mar 20, 2025 at 12:17:37PM +0100, Rasmus Villemoes wrote:
> Hi Colin
> 
> On Wed, Mar 19 2025, Colin Foster <colin.foster@in-advantage.com> wrote:
> 
> > On Wed, Mar 19, 2025 at 01:30:53PM +0100, Rasmus Villemoes wrote:
> >> As the comments in ocelot-spi.c explain, after a chip reset, the
> >> CFGSTAT register must be written again setting the appropriate number
> >> of padding bytes; otherwise reads are not reliable.
> >> 
> >> However, the way the code is currently structured violates that: After
> >> the BIT_SOFT_CHIP_RST is written, ocelot_chip_reset() immediately
> >> enters a readx_poll_timeout().
> >
> > I ran this new version and everything worked - and I've not seen an
> > issue in previous versions. I'm looking for guidance as to whether this
> > should include a Fixes tag and be backported.
> 
> Thanks a lot for testing and reviewing! As for backporting, IDK, I think
> we'd at least first have to know that it really fixes a bug for somebody.
> 
> > Great find, by the way! Is there any information you would like from my
> > setup?
> 
> Certainly I'd like to know if you do in fact use a SPI clock > 500 kHz?

Yep, looks like 2.5MHz

&spi0 {
        #address-cells = <1>;
        #size-cells = <0>;
        status = "okay";

        soc@0 {
                compatible = "mscc,vsc7512";
                spi-max-frequency = <2500000>;

> 
> And if so, could you try inserting a read and printk of e.g. CHIP_REGS.CHIP_ID
> immediately after the fsleep(), but before the re-initialization, just
> so we can see if my theory that the values are off-by-8-bits plus 8 bits
> of MISO "garbage" is correct? Because that register should have a fairly
> easily recognizable value.

diff --git a/drivers/mfd/ocelot-core.c b/drivers/mfd/ocelot-core.c
index c00d30dbfca8..5a2762b6ecac 100644
--- a/drivers/mfd/ocelot-core.c
+++ b/drivers/mfd/ocelot-core.c
@@ -115,6 +115,8 @@ static int ocelot_chip_reset(struct device *dev)

        if (ddata->init_bus) {
                fsleep(VSC7512_GCB_RST_SLEEP_US);
+               regmap_read(ddata->gcb_regmap, 0, &val);
+               printk("7512 Chip ID after sleep: 0x%08x\n", val);
                ret = ddata->init_bus(dev);
                if (ret)
                        return dev_err_probe(dev, ret,


Prints out this:

[    3.360986] 7512 Chip ID after sleep: 0xf0e94051

That doesn't seem right. I added a print after init and it makes more sense.

[    3.351656] 7512 Chip ID after sleep: 0xf0e94051
[    3.356828] 7512 Chip ID after init: 0x175140e9

That looks better. Good find!


Colin Foster


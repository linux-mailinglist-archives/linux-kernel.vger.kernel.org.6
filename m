Return-Path: <linux-kernel+bounces-317356-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D62D96DCFD
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 17:01:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CBDDC28A3B7
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 15:01:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50C951A2572;
	Thu,  5 Sep 2024 14:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="dNQvquib"
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazolkn19010008.outbound.protection.outlook.com [52.103.43.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7842B19D081
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 14:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.43.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725548297; cv=fail; b=s675DvPq0u+kM02Vo1NlQLD+rwE3vMkqCjddbGXBcxTCyg5pu2hHh/Up+t/JiKf/bGmrlznOg2AZt2YZEKVpDnTIZK4UpNLkNptkTz+E6h0BlIg0VYEgwLe9l+nurs8ShOfqCWnTXZF2IbxAnPQEQuypASvL55plEDaV+UU81Ek=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725548297; c=relaxed/simple;
	bh=KMWmPie2eycYc8yuP7VMgM7Z6PLSiJiBPFZajgKB2KQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=V67nRhQdbcgnZqIi3Y+EQE6JMgsYFb9QX/HP3su1DHigfYXpoVUFcDiOZ7jSLvspBOwkJ3Z2as5TGAwEcHrwCW0R7Tu3Eg/fiAMwduKXMeArpP1CXGoO7e12jp0AxIrwFMwcgs+hE+PMwk+3TCmg1TetV/EkB2pHwUDPLzINsb8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=dNQvquib; arc=fail smtp.client-ip=52.103.43.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZL9JLVCeR9ZzOxDgvE3Q9VhVUYRyFS4EBSqe3/48/Rr9r2ZuWrxJiP+phqIygkjllut0FV+lfXZQrcffD288UaTlznL25lW4bertGB4r5Bs1uY+7cbA+gYy6Odyt42fLKy7XMEBaKiLpyM1dza3Rawf0T069Hoso8ZSCRbfjk1o1Tsx2t2ELrMToh/Iiqu6yEqgig1xaoVSVSEMT+Xc104eWikz1xV1ge7xv4/Euh4wH6Jorw4YbyRH8VcWYNraxTEUTquXAZtSHJP8ACHTOLlJ8/5muokQVy6W7NkzLELONvFQ5hGgIRJn4fOQ1w7eO9sas41hS7MWUxDaLabOb3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6e5vMRcF2s3jrBM5Adc2bNZMOnlY0bGJEY5abMMllhc=;
 b=LHI9n0pojLW/+oS1NQJM6WdmMJFMMbeMAcZHLnT7+ceuksUfgUCcp/fZ3DclCPgH+WXNF+l4pxJawi98W1skBDOhGaOszmHOg7xO+PsgBFRmnUH9VL9owvNiaGE9vqiMVytDYUoOwA8xqtzc/KVz5WrejSIr4+mB8GcGbnXZQvc2bwUauEPoTr6zTeOSoOcYrelRjYE+wDn4rml24HxQphAKh2B3kJCvIL1lMSij/2qswAuNdp+kW8jvRNfEmUKeRuQYaWfHExl1cxVQoJBv14jY5/UKx3Mk7JiiWjKS5jbH+nH2ff6uN/U9u3ucUBOauq9yNMAEyysW46R9reiL4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6e5vMRcF2s3jrBM5Adc2bNZMOnlY0bGJEY5abMMllhc=;
 b=dNQvquibbpAO7DalUP0F0tzT0vhf1CIN8tXVaQePqR1wRE6rstftVoYYzemsPBxd9kIw/I8kH/wi1dIFOEynvKL53xwIGkLNtb2VgfaLjGIVGLrBd9i1k77NNWranSEK+C8q6WS2vOIt4s7CHPmZF7MWJr80QBEAXjQv1I8l7ZPqyS+h5eOsFolSa1KLsADiEt43+gr5JXzqHf0BNsD+QH0bD2HNFUSxSxI8G1GNjTPNGasIBs2WMALxgdVSZCaDbO7WBlTIEzKYws03JMuqxk8RUolk35E58czjftiEDTSPmkBgGoTJ5M1fA9UH4G2Ii3eGauM96wtbWwbxWOUTDg==
Received: from TY2PR01MB3322.jpnprd01.prod.outlook.com (2603:1096:404:d8::12)
 by OS3PR01MB5672.jpnprd01.prod.outlook.com (2603:1096:604:b4::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.16; Thu, 5 Sep
 2024 14:58:12 +0000
Received: from TY2PR01MB3322.jpnprd01.prod.outlook.com
 ([fe80::2580:b866:1150:d0d]) by TY2PR01MB3322.jpnprd01.prod.outlook.com
 ([fe80::2580:b866:1150:d0d%2]) with mapi id 15.20.7918.024; Thu, 5 Sep 2024
 14:58:12 +0000
Date: Thu, 5 Sep 2024 22:58:07 +0800
From: Zhang Ning <zhangn1985@outlook.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: gregkh@linuxfoundation.org, rafael@kernel.org,
	linux-kernel@vger.kernel.org, lee@kernel.org
Subject: Re: mfd: intel_soc_pmic_bxtwc: irq 0 issue, tmu and typec components
 fail to probe.
Message-ID:
 <TY2PR01MB33222A51891B602C91EF0E23CD9D2@TY2PR01MB3322.jpnprd01.prod.outlook.com>
References: <TY2PR01MB3322FEDCDC048B7D3794F922CDBA2@TY2PR01MB3322.jpnprd01.prod.outlook.com>
 <ZrYMne34hVa33qKf@smile.fi.intel.com>
 <TY2PR01MB33222D8BE4B1107EB3A1917FCDBA2@TY2PR01MB3322.jpnprd01.prod.outlook.com>
 <ZrYjLdPryElDubaM@smile.fi.intel.com>
 <TY2PR01MB33224CE088EF01D57DE1BABFCD9C2@TY2PR01MB3322.jpnprd01.prod.outlook.com>
 <CAHp75VeMp9C04iDW5_c9owq3HP=5wvccoOuHwrSQ5SFeV+SRVA@mail.gmail.com>
 <TY2PR01MB3322699682DBE2F13F919F80CD9D2@TY2PR01MB3322.jpnprd01.prod.outlook.com>
 <ZtmlCh4NScc25tS2@smile.fi.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZtmlCh4NScc25tS2@smile.fi.intel.com>
X-TMN: [RHDrrxe7NFs3BshtWllMcqQKM+wGGHA2dDEhNWvts7wnLTxT1THzjCtf7odBElxF]
X-ClientProxiedBy: SI2P153CA0017.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::10) To TY2PR01MB3322.jpnprd01.prod.outlook.com
 (2603:1096:404:d8::12)
X-Microsoft-Original-Message-ID: <ZtnG_2k3c4SYv_02@orangepipc>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY2PR01MB3322:EE_|OS3PR01MB5672:EE_
X-MS-Office365-Filtering-Correlation-Id: 4190b469-5996-44cc-dcb9-08dccdbb29d6
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|6090799003|15080799006|5072599009|8060799006|19110799003|461199028|1602099012|440099028|4302099013|3412199025;
X-Microsoft-Antispam-Message-Info:
	FCwdCeZUaB5Mt9+tsFWTmtnPP04T+UF09aOLeMgpVnVeLVgRjTh+Osy9ua3maonYNbGq2JJqAtlxF62opwCw5X9kyvTZK2CxDyFC6Hol5v1rtsDhOCAnnCnY/HiMh03xrkhBMJEPnNJyN3fxf4fw0u6JQGkkz7RQoX8SR2VVdXH6nGxRapQOJZeAUmFSCAwJ00bIi2lEBoaq7f8Vh+mQdO+mAX1UDoYxzU6jlGFOz1O6Ua8j9rQplS4yhg8nVO9AX/ASgsaHJrB605rJNycHWnj4ySoeblemFa3aQDECP6RTDHovY8vl+feUaaS/Iv55H141rOXH4OFTOjqTaA3hVL7JKkaavbdqreYQBGk1QPrhQUZ24illC6XKRjLBoVuL8KWKpnloFdgN9YAI5ytcGoMzLnAcBphzkgvua2S9axzKTK+TPBbcyqGFnBjMIDbSM/52C3O28T0pNY90M3TTvlM9CH8cdBh0bpTwhxnI4B+uDFaTVHUfsJOwOxIAUK7OJPqVYj9gxLoMo6wLAqUxCmUqYsk1dXyC9Xgw90ZAL2lrDcXp6GlXTWiX9eWe3FSa61NrslE1q7QRFnBGx0lvN473LjL6r70yskHaU0VIvaF/It1N+/60K7yFoSvL6Q0umDo5GBsbV+kzFLMSr7AWxRAyPdBWeTd7/mYMTS2ZBPOy6Nqd1iacgoe1Kn65HyCVY8mVLIp/pUvNBYshjHCv+zZIizHlBWHXt2/4aVGCKIh4qguYFP67UFViqlWQZiUsDa1EZWQWz206otAl7u7Cu5rS5SnrUUjfYH0FxWPc9hj0HRxELVvIxFxI4Q0f8xXfSCe5ks/UDK8QxUPt36WxYVT5+AxvdeN5GZNa73cjfW+bPf66I+7LaJsjODYs0uBcMiXjRX2X4R42uILsmr9OUA==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bnZqYWZ6YVN0Z2NDQWwrSGZRUDhxYThwL012YkVTSUFSZjg3U2Y3MFRlMUhW?=
 =?utf-8?B?cDFPS1FZNFhMQkZzSXNYL3BTamwwL1BkdGUwK2Q4Q2JRb2EyOEhFVTVxa1NJ?=
 =?utf-8?B?bmx1dFZteEtlSnl5a2ZYeGM5VU9DbCtpNUlaYVV1bzJkdm1ueDdlSXU1UHpk?=
 =?utf-8?B?R2NXdlA4cWFHM0M5NTB2WDB2Mis5cEJqQ1dZRm9iQVl5S25leFJWUVZBT3d6?=
 =?utf-8?B?eW5WYXJLTXp3WXpmdlRsWjZmeTV1SUV4cUI4ejBRQlhWdlBvSHZsMzdTQzQ4?=
 =?utf-8?B?NjI4SDJrWHNYNXdBL1hZb2Z6NFV1OGRkTGVBMDZXYnRDUTZaeVRqbTJRRFo1?=
 =?utf-8?B?VWpLOG1hOS9XYnRiWkVhREdRT2tlZ3p1dGVWaUxiTkZZSFBBbjdIN1NXRy84?=
 =?utf-8?B?WXpESzZhRitBakh2UEF6WUNlUEFacHk2WUtPM20yeTdseWRHVjA2a24zMU12?=
 =?utf-8?B?V1k3UWF0OFEwTmNDNiszclRSMTdsY0xTVDlMTis5ejNBVzNsNDRSVU9ZYkp1?=
 =?utf-8?B?U2tLRHg0U1NpbWk0VEViV3NhTWhOTUl0ODlSUUpRdFk2blRudnJMMEs2REdh?=
 =?utf-8?B?bjBVMGpFeW44ZzRSZGhwU2VienVJbW45dDh6RWJyYkl6bmdUM3pTbTMyR2Jo?=
 =?utf-8?B?WXFITnJyeEt3WHgvUnVxY2pIa3M0d2VDbS9Pb1NNbDRMY2RpbXpUbGxUK000?=
 =?utf-8?B?cUl3cmZ0RjNrKzR2MExXclhIRFZSb3V1WjR2OHJ0dTNOZXc2UzNsZ05tQ3B3?=
 =?utf-8?B?OE05RDVFcU1kRjNQUjJMTDZZYjJnS1gvV0FSSTdwQ3ZWSVFqaHRzZGVwcVIz?=
 =?utf-8?B?WXpYaE5VT0hwSDdWQ3FLZ0lkMnlRbTlXQU01dHN5ZVowcXo2cERsN3lDc0lR?=
 =?utf-8?B?SFRERDhNTVVmQXE2L3VZeDd3Mm02NEcrTlhKbll1RFpLSHRuQ0IrMTZHeW5D?=
 =?utf-8?B?STMwRmdFVnlLVisrTlB6L0FBVGFFWC9hak91U21PY09VY0E5YkJXQy9HMm94?=
 =?utf-8?B?NmR0ZEgzc09BN3VCb01yM094c1dBbk9qdXQxV1oxRkFvUU1UMS9LYnFzaGlL?=
 =?utf-8?B?aGJRR3YxMW52b0k2WEkzUTk4a2dpVkozL25CYUxiOU1FTG80VlRwU3NQeGtj?=
 =?utf-8?B?OVVnUjh4VkNtQW5Hbk9mUlNSUG83Wm5ydmhEVHFLRHhGWFY4bGZiVFZ3Z1Jx?=
 =?utf-8?B?d0xxWGRWbFVxQVhIYW9pSDlEM0s3VCtUMWVobjlsSlNYYy9lRVI2cnN4L29k?=
 =?utf-8?B?a3RpSWliTHJMQVI2VUdBWUljM28xZU52UkE5b2FnNXMyUnAxZlpqcUV1UWd1?=
 =?utf-8?B?MzJHUDFlR0xOckpVRi9BZDBnbkJsR2M0ek1Ddmd4aTM2Wm5WYlh2cER4bzRn?=
 =?utf-8?B?Qng1R0IzcEZhZHEzYS9DTFFHUjBiRG9iV3dPcGt4NGZFZVFlditLRmpPMmZC?=
 =?utf-8?B?TjBPNFBzczRxb01CbzlheGl3L1lGWHZ6bDhMSnkwOXZaSVNHVkt0NjdZaC9u?=
 =?utf-8?B?TlBCMWNwUlg2eENZUzZFeGxPNjR1Qmg2ZDBOT0tiMm90UkFRSUhGSEhJRDJF?=
 =?utf-8?B?MEQxdDhkYVhwNXVZQnlSQzdBRitKNGNYRml6VnNyRzhOTXRDKzhoa244Rlg4?=
 =?utf-8?B?WTlHcXNqNndaV2EzVFJSc3pyZ2Y3a0E4UzN3cEY2L1NiekgrY0FiNC9VWklT?=
 =?utf-8?B?QW9ZYVIzSWZ3QVY2YVBOTFZsQlZXZEIyRXdjV0JzZmt2d2gwcjZnWXZlcWF1?=
 =?utf-8?Q?XQpjJ39lF+l9RUrijE=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4190b469-5996-44cc-dcb9-08dccdbb29d6
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB3322.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2024 14:58:12.6400
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB5672

On Thu, Sep 05, 2024 at 03:33:14PM +0300, Andy Shevchenko wrote:
> On Thu, Sep 05, 2024 at 07:27:25PM +0800, Zhang Ning wrote:
> > On Wed, Sep 04, 2024 at 05:36:35PM +0300, Andy Shevchenko wrote:
> > > On Wed, Sep 4, 2024 at 5:29 PM Zhang Ning <zhangn1985@outlook.com> wrote:
> > > > On Fri, Aug 09, 2024 at 05:09:49PM +0300, Andy Shevchenko wrote:
> > > > > On Fri, Aug 09, 2024 at 08:53:24PM +0800, Zhang Ning wrote:
> > > > > > On Fri, Aug 09, 2024 at 03:33:33PM +0300, Andy Shevchenko wrote:
> > > > > > > On Fri, Aug 09, 2024 at 08:02:43PM +0800, Zhang Ning wrote:
> > > > > > > > Hi, Greg & Rafael
> > > > > > > >
> > > > > > > > recently, when I try to enable mfd components for intel_soc_pmic_bxtwc
> > > > > > > > for debian kernel[0]. I find tmu and typec failed to probe.
> > > > > > > >
> > > > > > > > after check source code, I find irq for these two devices are 0, when
> > > > > > > > use platform_get_irq, it will alway fail.
> > > > > > > >
> > > > > > > >         if (WARN(!ret, "0 is an invalid IRQ number\n"))
> > > > > > > >                 return -EINVAL;
> > > > > > > >         return ret;
> > > > > > > >
> > > > > > > > My workaround for debian is to hardcode irq to 0, instead to use api.
> > > > > > > >
> > > > > > > > I don't know how to write a good solution, thus send an email to you.
> > > > > > >
> > > > > > > Hold on, how the heck you got 0 in the first place?A
> > > > > >
> > > > > > use tmu as an example
> > > > > >
> > > > > > enum bxtwc_irqs_tmu {
> > > > > >         BXTWC_TMU_IRQ = 0,
> > > > > > };
> > > > > >
> > > > > > static const struct regmap_irq bxtwc_regmap_irqs_tmu[] = {
> > > > > >         REGMAP_IRQ_REG(BXTWC_TMU_IRQ, 0, GENMASK(2, 1)),
> > > > > > };
> > > > > >
> > > > > > static const struct resource tmu_resources[] = {
> > > > > >         DEFINE_RES_IRQ_NAMED(BXTWC_TMU_IRQ, "TMU"),
> > > > > > };
> > > > > >
> > > > > >         {
> > > > > >                 .name = "bxt_wcove_tmu",
> > > > > >                 .num_resources = ARRAY_SIZE(tmu_resources),
> > > > > >                 .resources = tmu_resources,
> > > > > >         },
> > > > > >
> > > > > > this is why I got 0, and I don't do any hack.
> > > > >
> > > > > Thanks for elaboration, I will look at this a bit later (may be next or one
> > > > > after next week, just returned from vacations).
> > > 
> > > >    could you share the patch link to the fix? then I could port it to
> > > >    debian.
> > > 
> > > Sorry I was busy with other stuff (as well), I am still in the middle
> > > of debugging that.
> > > The issue is that the leaf drivers for some reason do not request
> > > proper vIRQ (that should come from the secondary IRQ chip). OTOH there
> > > is only one _similar_ design in the kernel besides this one. And when
> > > I tried to test the version where all this appears, I couldn't boot
> > > (yeah, I spent some time on bisecting things) the board I have (One of
> > > pre-production variants of Intel Joule SoM).
> > 
> > Yes, me too. I'm trying to enable Joule on Debian. thus found this
> > issue. you can use debian sid with linux 6.11 to debug this issue.
> > 
> > and another issue is Joule HDA pci id is removed from Linux kernel, thus
> > no sound, but I don't plan to submit an issue.
> > 
> > > Do you have any (most recent) kernel version that works as expected?
> > I don't try any old kernel, but from git log, I think bad commit is:
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=57129044f5044dcd73c22d91491906104bd331fd`
> 
> No, it does the right thing from architectural point of view. It might be that
> it was never tested or it was a regression somewhere. That's why I wanted to find
> the newest possible kernel that works on that machine.

in my another email I use wm8994 as an example, which is wrong, but the
answer is in this driver.

which is don't use platform_get_irq. 

in wcove.c

	irq = platform_get_irq(pdev, 0);
	if (irq < 0)
		return irq;

	irq = regmap_irq_get_virq(pmic->irq_chip_data_chgr, irq);
	if (irq < 0)
		return irq;

change to 

	irq = regmap_irq_get_virq(pmic->irq_chip_data_chgr, 0);
	if (irq < 0)
		return irq;

if move 
enum bxtwc_irqs_chgr {
	BXTWC_USBC_IRQ = 0,
	BXTWC_CHGR0_IRQ,
	BXTWC_CHGR1_IRQ,
};

to a header file then can use 

irq = regmap_irq_get_virq(pmic->irq_chip_data_chgr, BXTWC_USBC_IRQ);

this will look better.

I verified this change.


> 
> > > > > > > > [0]: https://salsa.debian.org/kernel-team/linux/-/merge_requests/1156/diffs
> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 


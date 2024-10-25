Return-Path: <linux-kernel+bounces-381820-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A1CA9B04E1
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 16:01:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D6781C222FE
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 14:01:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FF357C0BE;
	Fri, 25 Oct 2024 14:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Lkps5akr"
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2074.outbound.protection.outlook.com [40.107.105.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A30B42AA4
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 14:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729864863; cv=fail; b=is7e0aEPgxa3cUrXnW9VpNqkJ2ob6RQ6UB8hpCbqNgFCEVRT3BasWHCDb7f3/Jm1q3OUoc/ukF9ua/zLqeV11jAKWJudLK8hTkViitAKUki9klJDOC6YpDUauIEnLwQmdroFvq//UJcThcSvrH63XjBY9HdRPwl5ghf8ESgZnmg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729864863; c=relaxed/simple;
	bh=qmszAXC8FNWC90UnpmZnjl6bm9UN4HkQXdHSebM9uV0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=mCjSdoaChZrp6CiP9v+tMfTRM/+2R9uKQb9Z7b5Wl1hg1HaSmzWi4LLxQM02vwQ1F1gLOzVwEGpKzn9X8bAbYJLu2s8MAwFnE2RGfBgLlBySxEGW10zsaJpCoizrFwUiJ0LdewCC1LSlT0X9hRt6EeyKHa1QaEIYkULYxXyZcAw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=fail (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Lkps5akr reason="signature verification failed"; arc=fail smtp.client-ip=40.107.105.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t9FVE636wVYZewmqPX6Ee37m4wGLdbJ49B40C9NSTS/lOoN/MnegzzSLa6MLxbege0BZYl2N4ifBxhP41gVriGrYWusU+TzmMq6ZtiKhPYbtEbS7vvR098Jdv1mwESZhlSrTkWF5Ho3yNbo5r5wrqjBUe6dQ9xmPU9L4ho+h/aEPUvpFxmN5x34x14aa80eYGP5m/7X3QliEE/LlQDy5lqw/yZu1avyS8hX0QMCReMCtwKWqHQBDwcsX7wErR8kuGWT5EnTfwjO+LS+BWCOniigga824yfYfKEvrmL5Zo50JiTafD3pFn1sL5vKhNinUOreoqdRQ/Mye0T70cnK6iA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/6E8d2hgMi51EmBgusxPX3Gfkw5oR3Jn0SRlovGnEZ0=;
 b=Be5ydynxJE7NrqFCBS90+Gvz8jZ4GEipJGVSzkJ4PitZZ+UdZcaEQXwhOR/LwgQ1lrUXvOkr/6Sbxy/PL79ZMtG4WiDdQ9J7sUi6FIeiqp+454tHeNeHHSPgUR4giJZMhP1fqdtDKgrKL0+ifNZF5PPqfXvwoEE/qE6+8bdrSh+dTCrkcA5s8q3o11QRwBC9kuI4LW4FDNQWe+hF5OVKTBaBo7Ze5duqLAjXeDpmJuafUvMzWcU1FdkO8jxVp9tDsjJJ19epS1DNj5ny3kMeGcao2upEgeZ/EkUfcFSmPJsLBrJ9lWNYbnhorJHPWBcRlAkqFFigB+E4uz8qXQereA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/6E8d2hgMi51EmBgusxPX3Gfkw5oR3Jn0SRlovGnEZ0=;
 b=Lkps5akr8pweOWpZUBJTlDBbV64VXEiX/8NMKRIyimmQSOwb1dzLo5eOfH/2HatfRKQqmlD8R1iYiIWVvO1O2e5YUAyqtadWwHmS4HcxNh0DSAv8BktmSXWRR/Y5VSyWIUQYz86NEjER/wAXyEEdA43Ih139ccGjdiXtj10oqqtxL8x7aoFE6Qy0vK4M0JsFGWGksngcjbVAA2BHfib+fi/DV2lKSGtRSAJNrB+IIOztGuJAi7DIbT5UkkRkjo6tIZqrUrVUab3ZdtrZSy7UB4GAgjJ80vaPSEVjklyFusZq6H53G9bmIMffHuaOHJosA2HY2laAaZnWUqWKb4ZgYA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com (2603:10a6:10:309::18)
 by DBAPR04MB7239.eurprd04.prod.outlook.com (2603:10a6:10:1a8::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.21; Fri, 25 Oct
 2024 14:00:58 +0000
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::e81:b393:ebc5:bc3d]) by DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::e81:b393:ebc5:bc3d%3]) with mapi id 15.20.8069.018; Fri, 25 Oct 2024
 14:00:57 +0000
Date: Fri, 25 Oct 2024 10:00:50 -0400
From: Frank Li <Frank.li@nxp.com>
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Conor Culhane <conor.culhane@silvaco.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Clark Wang <xiaoning.wang@nxp.com>,
	"moderated list:SILVACO I3C DUAL-ROLE MASTER" <linux-i3c@lists.infradead.org>,
	open list <linux-kernel@vger.kernel.org>, imx@lists.linux.dev
Subject: Re: [PATCH 1/1] i3c: master: svc: Modify enabled_events bit 7:0 to
 act as IBI enable counter
Message-ID: <ZxukksXwyWN2HQ3I@lizhi-Precision-Tower-5810>
References: <20241024203855.1584416-1-Frank.Li@nxp.com>
 <20241025095318.4785df2c@xps-13>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241025095318.4785df2c@xps-13>
X-ClientProxiedBy: BYAPR02CA0054.namprd02.prod.outlook.com
 (2603:10b6:a03:54::31) To DB9PR04MB9626.eurprd04.prod.outlook.com
 (2603:10a6:10:309::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9626:EE_|DBAPR04MB7239:EE_
X-MS-Office365-Filtering-Correlation-Id: a42442a6-2980-49ae-1a9f-08dcf4fd7325
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?iso-8859-1?Q?VOQ1a39unZWCmG/VQvKUA40qEqkbwwMFZOgg98EZh8VU3UM28w0haabKib?=
 =?iso-8859-1?Q?g56yGvX2WWo5ve3Gqxgblg5Reh4hd58wg1YppepOuZCqihGjb6aedA5Q+h?=
 =?iso-8859-1?Q?LG52+La4JIeVovOIY/fyrDSSzWv9GujgwmCCheqwSNuMVimQPnfaGVWsbr?=
 =?iso-8859-1?Q?JpqfJ20C7BgkVJ4KdnDJ6l4HtK2wBJUOEMhT7lztOknGQ/M/87giP3MM+c?=
 =?iso-8859-1?Q?zemIREqBQWunuWuGGa/rnQWG3KKJldkHhl7Yfduarna/9ooB7tJzx/13Ro?=
 =?iso-8859-1?Q?1Zxd3tN7GM22UOSBecjW1NebJoHrNlGr3R5uSHu+BVO9VqBbu7JC5zamiQ?=
 =?iso-8859-1?Q?Kx1m/ZnUnRMUHt3ohSJLsUxixWgyI/1QjOJW7LUxePShz1OROVGcohppC4?=
 =?iso-8859-1?Q?GDuYmXb4OEMlvemCDw53Zx+VBqR28ARw/X4+96iTCEFD7Iu0SgIc2zuXwn?=
 =?iso-8859-1?Q?wm0eM8z9AuCGebs8dmaye1EHpUM9J0ryH1AbC4MXslA7jXPwPF3cY06tnt?=
 =?iso-8859-1?Q?nod1esdFQM/W9jlmSYfEgdjkEpitg2mOup5I2hsAg5OwIwH+J/JUSlkxaw?=
 =?iso-8859-1?Q?hjTzXNohtNOJZ63RVmgKi/4lUIy6S+Bg+nqGi+DMc9bRvVVzvSZWg9XIFq?=
 =?iso-8859-1?Q?VqLGx7GLUEEXK3qF5tle87i4OtWypudUB9hd39u1asHQUykOQ/bdW9y2yx?=
 =?iso-8859-1?Q?TwnDcx/xCcYxToWpjlO0AY0Cos7Lv5yULNo3NZuqNLAqAVvQVpKmUiQb4B?=
 =?iso-8859-1?Q?nf4oca8JaXiDujeXD1nBTnxzNxzXQt+xDUJJfILM8DhzgXIBLxGGCCKin/?=
 =?iso-8859-1?Q?VieQpJfBxjTTRBtLsQDMkFialmSXjHB4znPRHayDGE+pTd/4TYyQfPa8Aw?=
 =?iso-8859-1?Q?IYf3pTjr5wfHqglsop44x4V5PenrXhsZ8J0Br247yEw26JJs/UEr0MLs8V?=
 =?iso-8859-1?Q?9lbedQNIkxCebQClUpshM3p3OQ6X32wHPpkpvVfYPefMA9mR4QiTuIufvO?=
 =?iso-8859-1?Q?hTuIJM1ZYTOXQTd/GfuM1wFMRcAjTNMTJOTYBVGwsPMEYYZXngzbziNxrX?=
 =?iso-8859-1?Q?AFr11eBVByvDdv9yzyuYx/wahZQCpEQO/MSdJ1OrHcu/63oko6aVehvXLz?=
 =?iso-8859-1?Q?izIAzDX+/d661dx7M4UDx3tjxiQCvq7LSAOv/ZdR9X5xhgkI2mXCu8XtOS?=
 =?iso-8859-1?Q?FjVsD8bCJR7EjrR6QlyqwPYM3F/eYkQLG2cP2nm50JOCp8kp7YAnrGrx8b?=
 =?iso-8859-1?Q?d/5X65T5MgoEt10Y0yjTfHNosQLZPscArdcw6DrjRyxZGhW/7tMew9DWfY?=
 =?iso-8859-1?Q?N7TJJTsLdKeodGTcYjUy2sie4k2+Xg7harX+usSE9wzVgx8KB05cyfRYsN?=
 =?iso-8859-1?Q?N6hJmSIJIj/WIDBlgo5vs2vYBHE5atTZZmeOzR95tRIsEhr6fIfAs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9626.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(52116014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?QkxOyAo+6/6F7AxJ8NGlN0f2+AsjKoiIJEvokzRsBVKOOrdPJuVE2MolEo?=
 =?iso-8859-1?Q?kZSnHa6EO21W9Ymc8RKt8vhIU1z423qMg7X5FXzxWlzRkziW/nTS8Mf/YC?=
 =?iso-8859-1?Q?mvgf7b7wNmVz936N0jVWOHaLenI08bNp3Q5bdigBi5xbMC8hfy6CnojJU0?=
 =?iso-8859-1?Q?IJdyDZDSuyfFT0M+HhrHtlEqEj+jcpOXhy+HUjvmTKU5VbwSX6w0N4GUFF?=
 =?iso-8859-1?Q?aVCEZ9cD80My9VmyF2RavdsiefvL7phlhpoRKSZNBIsqJ3t161mZyEWqg/?=
 =?iso-8859-1?Q?MiU+in1c0eMXfJ0HKpxCqSAnRtE4fAwV0qiBdqGX7O9pCmn+D08oKHBApf?=
 =?iso-8859-1?Q?Xfi4RfmYh/diC5+ni9KGgXpqZf0kEp4G+mIw4rE6fqR0rhKO+g3ZeVGarG?=
 =?iso-8859-1?Q?7qF/H9TH8fu73VL9S8M1e+gqclvdr6B4g4oL4zQbSk8qF7nycbIQnULzAX?=
 =?iso-8859-1?Q?aVHgdJX2JB1VfJXOTCxcJDKyCiXjEQ/SfNLS526cXwh1Njf4ChPCYdlQF+?=
 =?iso-8859-1?Q?5YSCPwQKtNMqrjPYvuSPx5otcysE3Q8Zn64OdrOFF7w/6bPHQB56yc30/Q?=
 =?iso-8859-1?Q?6om0iSy0RaGcIRIgx2gZPn8JCFhSxbz9siXcM40ydmRgDM+yyQyr96lI7W?=
 =?iso-8859-1?Q?kDGIrrAS6vOzZRjpPFSyqVUaefcThgXls3Cfuq3lcZ92+mjWPTbldFrKCi?=
 =?iso-8859-1?Q?AMID1ujx404vmJ3mPM//VYqzoWi6P5XMZhQyCEC8SD6HMJS152PawYPs+h?=
 =?iso-8859-1?Q?iT6clNdJWU0NbWcstEzCkNvDMi9ToMiUeeQOZO+uEEN8XJS0P68ufgLI7+?=
 =?iso-8859-1?Q?/1sjDRH+ODwF9zRsiMqTb7ofULLWiy2z/EduPhXTlbkFrqooljczczJBua?=
 =?iso-8859-1?Q?OIxBH/cULFUrOG8pA3k9Pj5c4BTMW+LdsDvw64Jkj+uFcIpJYDM5WBwvWg?=
 =?iso-8859-1?Q?D5r2RADpO1+n3NFr191zyzw/+i1fxsdWlKurR2ye5bZ6oTXIHaUf5DScL2?=
 =?iso-8859-1?Q?3WpmDUC5sMdYjNlLhyPtnwuMIWRxZerM7ilDu4ltHHRbK1lRkCidGo0Rox?=
 =?iso-8859-1?Q?ga8kwmW8zaO+2sL788guyz1m9zq51b2mD16w0+w1vMf5rWchPTwTY+gh3k?=
 =?iso-8859-1?Q?/qPBCqL7zFBUDSiUYL/bIFyPuhSw1CxcWYMKzvdI18SmGu8TL5mJgT6M7p?=
 =?iso-8859-1?Q?E4twyZpZjVmIDfWOl7O0dr6mbiYp7QPj5UnF7yEGZ3/y5ec4BrWr0WEi2l?=
 =?iso-8859-1?Q?EDSvEhzzb8FM0a9gf4o4O4F6WhH+qyVcthu8zOZ/N60S9nYCQyP2LaaQPP?=
 =?iso-8859-1?Q?hIZmGIITC+aPcnxX6fiSBVzh7j+s3tXCTrlM6+88JXwr+IM+6bUBEudRYa?=
 =?iso-8859-1?Q?nRY2LLwSDC9D+0xSV2OYxcyZiTcyDhzW9PMCH6SmQ/9/hKNgdJqTYDZqVG?=
 =?iso-8859-1?Q?/8cOmDc0+mmviY61wjn/6EaNgM5qJdk5vbvhtLOjj0oWhmTyBGzjvzuQJB?=
 =?iso-8859-1?Q?yteTpONSDIJiuFb5DyPy82SlF2Z3KykfOnrpRMbTGRhOK7LO08zLCmDcE3?=
 =?iso-8859-1?Q?4I+IiMWoI5oOhc7wPYwnzPKMDkm+DLAFLKKGCT1UQZo8T5YHP7pRNoHCSB?=
 =?iso-8859-1?Q?R4AhGzHpIjs/R+g9CgY4Tllc30rOhAMnhB?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a42442a6-2980-49ae-1a9f-08dcf4fd7325
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9626.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2024 14:00:57.6728
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d3HGtYrpOcgmeYtbZLWHDshZuZ+jy3iiuUZ0TKNC7peMbRES2mOugJbMaCw4qdKYGFRq+6uXJAs5qVavzdQWsw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7239

On Fri, Oct 25, 2024 at 09:53:18AM +0200, Miquel Raynal wrote:
> Hi Frank,
>
> Frank.Li@nxp.com wrote on Thu, 24 Oct 2024 16:38:55 -0400:
>
> > Fix issue where disabling IBI on one device disables the entire IBI
> > interrupt. Modify bit 7:0 of enabled_events to serve as an IBI enable
>
> Is this bitfield arbitrary?
>
> Is there a rationale behind it?

Max devices number under a I3C bus is 128 because dynamic address is 7 bit.
So 8 bits for it should be enough.

Bit31 as hotjoin, Bit30 reserved as control switch request.

Frank

>
> > counter, ensuring that the system IBI interrupt is disabled only when all
> > I3C devices have IBI disabled.
> >
> > Cc: stable@kernel.org
> > Fixes: 7ff730ca458e ("i3c: master: svc: enable the interrupt in the enable ibi function")
> > Signed-off-by: Frank Li <Frank.Li@nxp.com>
>
> Anyway,
>
> Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>
>
> Thanks,
> Miquèl


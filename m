Return-Path: <linux-kernel+bounces-429687-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A16F19E1FF7
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 15:50:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6777E287A4C
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 14:50:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C28EF1F7561;
	Tue,  3 Dec 2024 14:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="pvMYZ5Jc"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2041.outbound.protection.outlook.com [40.107.237.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 680D21F7070
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 14:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733237408; cv=fail; b=P89nUrO+uePyUMwxC3yXWj8CTHogo51IEzw1PVoeVrCKXpyvjxnyYDNbfhNvUzG4J/PQqdAPENV7i/06ZtRueeAbjMmIAmz9RJwklygl9GovNPiVhTYuGsE1COAVb/d27HzyC3nmFZsfHwCWX6H4mI0961lsdhaQHan3kuxxLsc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733237408; c=relaxed/simple;
	bh=IVv46XT9vmkLNjnUzksvQ/JMeWMo3PDC9GUnT9BNCBY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=DOV9kCCGkR9ta5pl6mcIijuSJbAKuzuUBCIwiBebMfVPRbbcHqWDAKN1jds/VAvIZXoQ6eDvgNJeZ7hITmeS1MNhj6eI+HBevp/Rb+qu81jwxX3VTAZRMiZJH2+zxZRM4TSxEWb8O2ibLnJbwZ1kTMH7QRO9MJt11jJYya/JTtU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=pvMYZ5Jc; arc=fail smtp.client-ip=40.107.237.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pUPWn52Rb1he95BoHBdSj387H2xx9n96HSv9GYWPFuFytgzeHOJ+d19xX8SB2WcBxuJRlSxt0Y7zKuPjgKANPinUskJutUXn0Wiq6jlA6VDKQFIa+iyNFsYdz0yyQiqGfgyqjFunKWXUXx6Kxu5ZRV1f6t3v8wuGQrz2BZO3/EwTWhMaS1Gd9ZbV5ThaFp1i6NMXZHBYA2CvMEELgP1DKPghZISHYqlf+e2GuSxbnE5/Oc4ED5QzqmFHW6A+TRuaxWQ+2MJPQLM5EViWTCQkE+bcCaLMZ6eCa90gXXZ7i5tTlWgwwyNbyJ8b6JfaSt8vmrTY5VGIhjPdo/iHyJqYBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gzO6+SuFA0fHblF6jf+3o+QRd3Qdh2rAsJrYAqyIksk=;
 b=d9t0G+ZP3m/cm81zCONDJV3BZCdGsWak1uAwRx/8BVrUktRwVkvPL9lvshvL5WT5srbGK/rpuS/IyLYlBCMwOlJK+xaAr5sMw0X/Zg+VIVUlOpGGbr7NcmD+A53JuALFrQbFEaUARs4uawKJwz1E68PgPPzTN9e9wgc9Ql+TNOwy/U/GRI7+JihA8HmhU+XJHxGwJdS/c8xXDCtuaX8ieGX0Kmm4c+hOpjkaNx7iEVsKa9OnuYyAYNnI9T8Jo9Ez5e+JIsBEj7GWz3/klCfHr1Bp6M4iStWAgpxmlm8gp7S5ryZ9WAc5/Rra+i3W5+YJe5h3j/gwWsGg3yUWt/cfkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gzO6+SuFA0fHblF6jf+3o+QRd3Qdh2rAsJrYAqyIksk=;
 b=pvMYZ5JcNfQUFD+C6IOo7dK1N336/0dskt8xZbbacyXuF5k6H2QUTFg7gp+TjnrI9igMZGn6BvdAm/wq1Ewlw0rnXsnqFttbcbFEaLBOrlW3k/YtLtPjd6LZET2MeegzToFpDeiyQ1Ks8ggdK+8AbcSViP9KW9/JCuiFtADBELSAGPgA+og+KKUl2IsOA9iNPOtQeqzjgeSQoVRJ0OX/jGUPj9QrPGcDzyr1n6Pi1UVEhdmD2TNGqnfZt90YcxdO1L0U5Wee4RJ7U/3aA4Fohm8C0NtJkkrTtYT45SVidSnEIC/RfgnZ1CRhPabAV1ioD5lHs4YvQ1aKsIIIch7XbA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by PH7PR12MB6444.namprd12.prod.outlook.com (2603:10b6:510:1f8::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.14; Tue, 3 Dec
 2024 14:49:57 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8207.010; Tue, 3 Dec 2024
 14:49:57 +0000
Date: Tue, 3 Dec 2024 10:49:55 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Mark Rutland <mark.rutland@arm.com>
Cc: Uros Bizjak <ubizjak@gmail.com>,
	Alejandro Jimenez <alejandro.j.jimenez@oracle.com>,
	linux-kernel@vger.kernel.org
Subject: Re: Help with atomic fallback
Message-ID: <20241203144955.GL1253388@nvidia.com>
References: <20241203003856.GJ1253388@nvidia.com>
 <Z0747n5bSep4_1VX@J2N7QTR9R3>
 <20241203130848.GK1253388@nvidia.com>
 <Z08YT5nD6uHC-PSm@J2N7QTR9R3.cambridge.arm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z08YT5nD6uHC-PSm@J2N7QTR9R3.cambridge.arm.com>
X-ClientProxiedBy: BN0PR04CA0128.namprd04.prod.outlook.com
 (2603:10b6:408:ed::13) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|PH7PR12MB6444:EE_
X-MS-Office365-Filtering-Correlation-Id: 546b77e7-2ad5-4101-b496-08dd13a9c12b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?kr+5ag8T1PYCv0pqLNY78axmcVndWi2Syggra+OUg3oX2UF0jF3R4wxgE2YH?=
 =?us-ascii?Q?LtocLm2E2qV4Q+GF/MtMRVJ7xzEnS2bm+81JxLnjijBC3qRvTGJML7HH4wxK?=
 =?us-ascii?Q?tDrFDHP7KvyUuRGirqOk0POrGGi1DHpNrBlKHQ2SbxqKpJNgIz+RbyFXeyyN?=
 =?us-ascii?Q?o+hO0sTAFeoQq8+Z3sgY+w74EyNGPG6tgfOV0dzJkPXwGk8F5fuh/Do4l+Mu?=
 =?us-ascii?Q?sAgXLOvqRzrJ0hyB4AzuRrXs7yiFvvA3NofyXX+sLw6Xiq9KQhNX9S1WovBJ?=
 =?us-ascii?Q?XKkATkMSmiuX2kWQKasmss4g+wSW+/hfnewfzxtJy5Wr3ukIkDiWT0BkMCcr?=
 =?us-ascii?Q?vvZEI90MmaoRNfkGqEG/LNRqEqynKH73YqgQvgGTaEH/SDYxJpVd3AwUAyQ/?=
 =?us-ascii?Q?7QURYHm4tDDE+19O0AEvkEbMunwsgwCXPbJ+sSZVb/YDRLD84Oo2EsiaMErm?=
 =?us-ascii?Q?HTsLr8oC4zbF8z4kp+T9HSkbca9ZFdDnNB00ZUHM+1Bwuz3bLxYHIT6IiLv2?=
 =?us-ascii?Q?HBdKyoYEVeJRP4iaqcaCrDtWg/nV3WV6v6wVVu6QYL1sYcwN7RBK0aNEGHsP?=
 =?us-ascii?Q?cbzPAIl7t48CcJHkj5pMfblw00gbxqD4V9+YpnH2ccob0TUpOOhbgXmx4IHY?=
 =?us-ascii?Q?Brfp4xpHyBjtU/nD/knXarnrPFqPP8xI+gmaOXreZFm2nmukwuqwT7b2IJXI?=
 =?us-ascii?Q?cO26zx5kYnMXkNY7WjBxFtw2X0NsYZzofuRHXXUeESK+nBXCGDXkNULMUygY?=
 =?us-ascii?Q?3zC9sUz1kqHNeXNbIQilTx3HqkFobft4C88PJOMb9eoxKBMVqBB88zIkUmoK?=
 =?us-ascii?Q?PlV/rczh9YMerQNrrrJok1XCKXkjjIlrlGlFt2KZ4JFcRDHW1+ddeCHF7q4V?=
 =?us-ascii?Q?w+oAu5DNJF2R35nLHVA48hkEUjvmuYtcbDWs4R9ivXtC9gGvge5E0SK/dxPQ?=
 =?us-ascii?Q?a5xHaS6b1wwGlqZRuIyVGyxOi2fAAmwlDGPWy4WsuR3WRFvePCFxCg6RDm7q?=
 =?us-ascii?Q?nH73G2Jhlz+u14rXZBgpP3w6LKRe5h5Kg+HhprCdNDSOQFCQQwIU8HkBUYu7?=
 =?us-ascii?Q?VSoL1/CiaMNOhZCTsmaQ6nC75VBO4S2IYsE3bzAqd8tTug493htVwDocATC7?=
 =?us-ascii?Q?oTJZwtRpZhSm8T1RW8vkA9Je2pBIhzZPpjWK75Vfq1YgSwhjV9nNxGoo5x4r?=
 =?us-ascii?Q?n13QKTjPWltEaGYNfB9YlFaQroht0Q8sTyuMHvy9ywnbcO0iG+Dmi++LWFjA?=
 =?us-ascii?Q?nJI0gUEkNdRp7osjg6k3vJ/QmBj3CTNlbXx1G2hU6m4t9SOOIz4aH58E7DUE?=
 =?us-ascii?Q?DITJdn+H1fX6VKPPzOdkuEs2GxxDzMS0iqFEWlBp5wkI6A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mwuavV5bX0+toDyGBXHVhJVkwRVIra7bQgSYhTnG1aJy6br0Ja8+JSn0Lhbm?=
 =?us-ascii?Q?DrJCs3gRQ+9jttsW/JbKt94zXH3dBVzLgAZVOiO1/lk5VilvePSq07ftrrIJ?=
 =?us-ascii?Q?y8zk3dqb7LENn8CS/rjWAe1vHdyA7mpnuuAdeQMch7Blw7lThEM7NDDwwQkn?=
 =?us-ascii?Q?k5MP11KO0tBR7kYQ9zv/N867takssl6X4XbxcVfuwlpRDTJrvFlr886ARBFl?=
 =?us-ascii?Q?wuJIOizJzdDiwzUztSO9ST/Gog/hirWGVja7y7KgolaYZg7zlRY/gd8WJrBc?=
 =?us-ascii?Q?Xd9Fd7f/iEvJfaY/XfPZZuSZQNUgqrz+/mlE7FET5mQA/TQOR/wcnovgWljh?=
 =?us-ascii?Q?6KC7GLio8Fh6jU24090bkiWSgMjWnSl5L/EL16a7JjapFBWWDk79TAYGFcFh?=
 =?us-ascii?Q?faeygbT1Qmpst9+6PRvgF5oPzLPZeQfw/FU9R3zL5biTA35A9nbzfa/LK0ww?=
 =?us-ascii?Q?Q4XnRx6RWQ08UEisAlfVCWd4a1xKQ+Dnbjc5AqFn1cq9eUU7hOUG4F7YM/Fc?=
 =?us-ascii?Q?W1UxGW5d6WeQzd+/UzBkkbT3G7ChiBL63TP38SYWj/uXAbR2cf1C4e60Cwmt?=
 =?us-ascii?Q?wlggorjZVyl719sF40eBnM5AJ65MOiDZudPRkRQWQmm0k3ss28M9bUQxf84p?=
 =?us-ascii?Q?JbBOJpVTYunJ2IzfhLBHDjKZqCc4MDtx38t5EdYEjC4OdveX8JmYI+TL/JP7?=
 =?us-ascii?Q?7lkU2wN3id6jorpE0B2FR0kALJoKj09tz9Cunz4CYUGemqod6oUp4LfvqTz1?=
 =?us-ascii?Q?44hR/PBe1Woo/+mX7889Vrss+kUyzqpLwqDPL0WKt21B1pikFmhJo9dVPCqZ?=
 =?us-ascii?Q?xK8i8EJyKnOmHdO8nC2+M07AChZe6Q8w6BXmCgTBFOXKLJ6C5sgsK5bmiQZ/?=
 =?us-ascii?Q?YVly/TLGp1J0EhkEafrqExNx1Ovg0tpqXsegynJ90NbEW00hcNYjA9VsmRhn?=
 =?us-ascii?Q?NP19IqFW701Ou1Uinj66Zt6fJY+YCOv2RqIieOIr7ELZwe+0TC78whsN1ciG?=
 =?us-ascii?Q?ODznvJ7z7bzjORUHTYzCVT7aWQKBM62cSwxj6E90oww+9ONV9Tq4bNBQN6gA?=
 =?us-ascii?Q?y2AGhlO7W129sIflXpQoYphjWbf0oNCH1NhS1zSxfgiVelp0ccnDao3tzlFe?=
 =?us-ascii?Q?4jxEQP4KFXl5pnLvwDHA/n2/kJe0zSj6gjQNOPSd1VB/fZYEjuQglseLuLgt?=
 =?us-ascii?Q?jCqoZcAK9yWkTg+rf+OswG1zlBbRqWtIOEZ1TEES+7BMzaAGeJKaaRp19VWD?=
 =?us-ascii?Q?Sg92bLP2x0T6p3wDIGwCH2aiOnOk1fzfCgDwmwYCLMHyxmkLHwM9iPJT3g2F?=
 =?us-ascii?Q?x1TNhieQ5J6uHUVKhm9f4wtJXXZ1FjHaxTJ8hq39K1sotFPRYgX/FP+wFV0r?=
 =?us-ascii?Q?nsoVFhw5io2iAcktWrg4z0xpsw5qDeEQWF9E/uSZQa2iZMrq9RnECCV6nBaI?=
 =?us-ascii?Q?4ubp9gHxtlTQtSWJ+0hbs2RCm1SkDqxUawceUan5p7PHGZscTXWxHAMQzLw8?=
 =?us-ascii?Q?2Yy697Xa0VTfIIxl0hEno59MwRJAz+vqx4p93MHKACV1lnt12i4nzq0sbmuh?=
 =?us-ascii?Q?Brxp0iRbZdGGVJgjNR6HNWqa9LLZaDV2bhcshWfa?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 546b77e7-2ad5-4101-b496-08dd13a9c12b
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2024 14:49:56.9597
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AQV6GZd8WZpn8U32YJy7oQMIG6r8+/XFUSZC8r3sSgw7+kCVhtN7HgoHFR+US2Mm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6444

On Tue, Dec 03, 2024 at 02:40:15PM +0000, Mark Rutland wrote:
> > Which expands to:
> > 
> >  old = ({ typeof(ptep) __ai_ptr = (ptep); instrument_atomic_read_write(__ai_ptr, sizeof(*__ai_ptr)); raw_cmpxchg64_relaxed_not_implemented(); });
> > 
> > And no compiler error. Presumably it doesn't link, but my compiler
> > ICE's before it gets that far.
> 
> I don't think that "my compiler ICE's" implies "compiles OK".

Well, it ICE's later. I'm using the 0-day instructions with
make.cross

during RTL pass: mach
../drivers/iommu/of_iommu.c: In function 'of_iommu_configure':
../drivers/iommu/of_iommu.c:163:1: internal compiler error: in arc_ifcvt, at config/arc/arc.cc:9703
  163 | }
      | ^

> When building io-pgtable-arm.c for ARC (with your tree!) I see the same error:

Okay, I think I see it too, it got lost in all the other noise :\

Jason


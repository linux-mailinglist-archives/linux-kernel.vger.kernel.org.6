Return-Path: <linux-kernel+bounces-315152-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A8AA396BE99
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 15:35:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C57A1F24A3E
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 13:35:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D2B51D9335;
	Wed,  4 Sep 2024 13:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mysnt.onmicrosoft.com header.i=@mysnt.onmicrosoft.com header.b="gxAWyfDv"
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2090.outbound.protection.outlook.com [40.107.247.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BD751D9D96
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 13:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.90
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725456944; cv=fail; b=r3qiVxLsJUCnHiAT3kfGdSA3jNNgirrCRH/4imA8ZqHMLY03YxXyBO6y5S7wLknX+JGkBvIiM5efmxG3bK6Vz+N8gJErD1yPIUQmYKNkcCHrrR0uwWAGLj3A5+V3vjabAn2Dt5cVAOi7ESFN6+OxiCUMg9E52xGajgX4a8FPsu0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725456944; c=relaxed/simple;
	bh=AXv3n73Q5aG2WId68rgmskmOLnL3HPkK6zHf6bOdjC0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=b9m6I2nXQnadrqh5mOVe3pOxjbGlnI276Ww90OXeXvrXSRxDTr5q/ccKqH1tMIo+lpwcR8JtNhlBOSYJSjkIXMgg+Xi2rlkKbNFB4MITn5erz8pX40cf1yg9Qdq4H2RHmPV4vDyR+412vVgocz9A7bgKvlhZXIK8LvmjikvL/P8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kontron.de; spf=pass smtp.mailfrom=kontron.de; dkim=pass (1024-bit key) header.d=mysnt.onmicrosoft.com header.i=@mysnt.onmicrosoft.com header.b=gxAWyfDv; arc=fail smtp.client-ip=40.107.247.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kontron.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kontron.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tAKpxzF1bfI3Jd8Lr97RiMSvzLd4ThuZ/1qYOweiolUbx0xlGY2LMPOM9wxRto3UooITbdlPxm7srrFjRbeqes1KnHUWbPLfubz/H3oIn041jjIL7zaqjyHk97lmApL4QuwvRONRNQ8BbwXFkGflU30sblLFudIEBO4GLObDAVtzLolQHhZ+Xol+GR7CpmEw503sq6VkIIhOHKRtExcB5PzHkeHWTdAv1h1C+A9cCOy5+wVnczhrZ2+nVSMxvWy4zmq0j8nny1+LzyytIn8IXB/Zh44P65jadCSI1A+olUChipXa8uN+OaAwaBRgK06R+N0BUGJ+zmzB/arxvbUc7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EYvsCfUxy52Kb2vIpNbwwqP3BdiIjIxCZKCkGNB10IQ=;
 b=mVoasDvv2cFXZjhUwc1J+Beq+5pPzPjllnmijadNtX4e1YS3x3xSj2qjl+x7UFNwJNdCkTgTCVfrn7J07wOk6Nx8a1nPQKt5o1AtlTNVRKhjZuiMI7k0dZGxmtL3UEpFP8YD+DwG3g4f3LdEaBdhPhwSP84EOoxbANUPoxrwY9NkL1otp0qFj3yosrZEzBysSvXGZ1uKWrwzAgSfL8U4QZkp2pyTqn/WFvM4iAEr+QeqzpfdlOYlr+3ThLeFDOY9QePQgtoYVrXnyManFXyFf7oVz6a8lhULiu/e5PIq3WBAFLeMDuAr4OY0bCIBdzFYMir1mPUdjQhTZcU5kIxY/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kontron.de; dmarc=pass action=none header.from=kontron.de;
 dkim=pass header.d=kontron.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mysnt.onmicrosoft.com;
 s=selector2-mysnt-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EYvsCfUxy52Kb2vIpNbwwqP3BdiIjIxCZKCkGNB10IQ=;
 b=gxAWyfDvPk9PkgycbRrLZLsHB9BVCl8Qv9qqijnvYoRuNqJQNBDuTijk6jd2FC0EPuzt6G17hgiwoP1rCOqnA+YnS3JbD/DLByanUggpKTLdcJHsYQRk7aIDtF0hfp0pszRoTlE4IeIweuexepKd+JY6oB2CCP4O3gDprYOzD70=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kontron.de;
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:263::10)
 by DU0PR10MB7922.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:312::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27; Wed, 4 Sep
 2024 13:35:37 +0000
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::b854:7611:1533:2a19]) by PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::b854:7611:1533:2a19%7]) with mapi id 15.20.7918.024; Wed, 4 Sep 2024
 13:35:36 +0000
Message-ID: <c882eed1-9f36-4382-89fe-f56dd457a45f@kontron.de>
Date: Wed, 4 Sep 2024 15:35:35 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V5 3/5] phy: freescale: fsl-samsung-hdmi: Support dynamic
 integer
To: Adam Ford <aford173@gmail.com>, linux-phy@lists.infradead.org
Cc: dominique.martinet@atmark-techno.com, linux-imx@nxp.com,
 festevam@gmail.com, aford@beaconembedded.com, Sandor.yu@nxp.com,
 Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>,
 Marco Felsch <m.felsch@pengutronix.de>, Lucas Stach
 <l.stach@pengutronix.de>, =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?=
 <u.kleine-koenig@pengutronix.de>, linux-kernel@vger.kernel.org
References: <20240904023310.163371-1-aford173@gmail.com>
 <20240904023310.163371-4-aford173@gmail.com>
Content-Language: en-US, de-DE
From: Frieder Schrempf <frieder.schrempf@kontron.de>
In-Reply-To: <20240904023310.163371-4-aford173@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0197.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a5::7) To PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:263::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR10MB5681:EE_|DU0PR10MB7922:EE_
X-MS-Office365-Filtering-Correlation-Id: cd1319f6-589f-4eb5-bb99-08dccce6759d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aFc1enpDZWoyTWQ3YnFwek9sSXVXYWw4Z29uL0U3YmQ4YnJscHhGd3JiRW9G?=
 =?utf-8?B?OFhpVkRXZDl4QlU2T0xBc1dVa3AzamR1dWJVQmV4NUp0NTZOZ2FlaW5MSUh2?=
 =?utf-8?B?N2V4NFc3dnZZSGIzaDdIck1TaWJ3ak9oZHErbjNTdUp6RFQ4cy9MU2ZxWXNo?=
 =?utf-8?B?cEtSOW1TTEhYcXBQT1MwbEkralJUYUhtZUtuYmtrMG8xWW03V284SHgyNURM?=
 =?utf-8?B?b3ZpalF3QnAyQUtvZDYvbGhEMExTVnQ4RjM2cHE4eDFod3BwbFcrZkdubXdH?=
 =?utf-8?B?THphMnViZHhuZ2R6Q1lFVkUvWE1nbFVsMUxoTjhhQTBwVkFyaG15WnFKL0lJ?=
 =?utf-8?B?SUF3bWgyN3NhMkQvTFMwTEZBTStqdlhid3FnWHBEUDk3SUhQdDhNeTVzQVVI?=
 =?utf-8?B?cFVnSVExYXd1bUt2YkRFbjNzS3kwUkdYT3NlS0tDMTZUMXVrUkxLVERsakpJ?=
 =?utf-8?B?QVQ5QkRCeXBVd2Q1TkoxV2hpdGRJbklSTmVIeEJ4c1ZneHZNb1FkOVhvN3JE?=
 =?utf-8?B?QTM1RG9ENmNra2tQdXlsVWJjZThmS2JSU05PZnBYMU9XVlJ2RHVYQ1hDYTFk?=
 =?utf-8?B?NUhwT21zTTlvYlZNTlpkYVg4OTQwaXdINDFqd1BvYzRPQi9JVXdldHRZbXdY?=
 =?utf-8?B?eTd6QTJVRlpYN0YrbGFaTUFMZkZMZS9SKzZJemNIaWVrbEgvSWxQejhaUGlm?=
 =?utf-8?B?U0k5dFhBRE5QSnlSOGVoaHltY3JwR3ZjelRZQVhnZFFwWGtDQzIwWkRkdUZQ?=
 =?utf-8?B?U3ZoOVlNNEFIK0FITWJFekVwbzFOUGxHTU55bVdKUEkyTGIvS2Q5citPZnhj?=
 =?utf-8?B?QVFZVVV2WFkzaDJLd0dzd000anVVTCttWnFlc2VJRXBiUzBPSThJUHV1Q1Na?=
 =?utf-8?B?eDFZOWRLZkNiZVBHT1dDVk9iYzF1dEVyWGIxSm82SUpDSjBEY053MnVCZmZo?=
 =?utf-8?B?K2YxUEVpNnd5dk54UEZuN1pXeGFmTTZaU3N4ZjBPQXl4RlBRbi9qaHdhckxl?=
 =?utf-8?B?K3NHZi9Db21zVFNFZmorUUNHK2xIcXFFNnNGREU2VjVoZzBZdnZsd3U0Y3g5?=
 =?utf-8?B?ZDlCOENrRHRIcEhDTHl0cnFSWTNnZ29lYW1ONno5TEtpQlp0R2RWZ1NzYS84?=
 =?utf-8?B?dkFxSHJUcFdoUDRNV1JZelpIck81eHVIdWo2TzlJKzFnaHRXNERxdUdab2sy?=
 =?utf-8?B?THB6TVZGVFFOVWptQVVaWlpwdWxRbHkzbnMzQzI1di9ZTFhlR2s1Kyt1OENt?=
 =?utf-8?B?UnV6UTIrWVJMa01YSEFLNXVQQlNpQjRJVlN3bmlMWmVqckk3cGdHcUZ5ZnBt?=
 =?utf-8?B?RDNvTFZ0TkJXUWFZRFBoVXZjWE5tQms1VFVORW1nVkJFblZLOXdZQWRlWXQ0?=
 =?utf-8?B?SzNXQlduN1JnK1VvVi8wRXhES1RMQUp1WGlMWkt0Vk1EaWQrbzIydzFLUmc0?=
 =?utf-8?B?elNTN0N4Y0FOUnFxdEhVdXY4RlQ0UzA4NVV3RDR6MXNDclJVemtMcEd5ZzlH?=
 =?utf-8?B?bkU5emhvZmpWbUNndStlazJMVVprNGZoTUVCSHhFblVBeXJIcDJkcjVWR0xh?=
 =?utf-8?B?K3lYUGFkWmxVcHZ4Y3psSk9FdG9HdzhPL0ZyZGNtMlBoOUNPbUthSkxYSU1Z?=
 =?utf-8?B?a3NobEt4WDl1MDY5UXVFWndna1VpRUJlN05sUUwrcSt4ZVQrQU9NV2hnZUpS?=
 =?utf-8?B?cjY4c1JweGFucUZTZDAxZTVUV1dhVDFMeUZBbEppakFReFhUWjA3U0w3eEJE?=
 =?utf-8?B?N0hUV0lpbDMxazhBb2xEOHVFZjlSajRNNEw4U1JYY0lTYVBRdmZTeUp5RGpM?=
 =?utf-8?B?NytrTWQ3WEs2ekxzM3l1Zz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?emwzT2pTRGJ0M0I3ZWhNOVh0T3ZVTWdRYjNieStZTCtOY1ZJdmxvL2lDOU1r?=
 =?utf-8?B?N2h3T29LUXAxWDlTanY2d2ZWQ1pyLzg5Wk9pOXNXRE9mT0ZkSEhGaTBEd0lh?=
 =?utf-8?B?MW9wUDUxSEs5dTAwc3VKcWswcm4wZGhnOEIwclBnMm80bzdwV1ByMStCVFBl?=
 =?utf-8?B?RW4zRHlZa1dlWlptOVlrL0dJOUorY29XSU83OUNVRE1aTlcrcVdZUDAweG13?=
 =?utf-8?B?bEJkNWZ3aXpReVR6N3ZvZ0lyd1VjbGx1U1ZEVk1BQ3NDNG52bWg2VjFaVXl1?=
 =?utf-8?B?ZXdYdlVDalRSQmpWVkZVUkNCZlBGT2ZsR1VHM1M4cmdDRHRXSGgwN3FBTW5p?=
 =?utf-8?B?aGJsZUZtbFlZRHJ6aFZzVVdLOUpWRzRpSzRWMndOeHNva0UxUE1OLzZnK2Er?=
 =?utf-8?B?ZlhGMFI5Nk5MUGZtTDk2OWZGbzVwbnN0Y2dzUjNtai9SaXdkVkd4K05uUlk5?=
 =?utf-8?B?OE44c3N0RzhoZ2doZGJFdmZoMyt3MzVZZm95cEZkMk0zQzI4OEY5UnJDa0N6?=
 =?utf-8?B?U2ppTHRJWmNCZFBieFFvZzNtOTJmT21TSS9PZjVla1RVWGQyTG8zT3R4ZHFK?=
 =?utf-8?B?bGZwRFdjUDN3UkJ3YUtGOTZZejMxNG9LbVFuRlNhSkZQeFVrSnNvb1VoZVlk?=
 =?utf-8?B?QXFnUVpObUxGTHJNNHdyUTM4TTl4OENnVndxZ3p4MVp3NVU1MHVCbi94UlBr?=
 =?utf-8?B?RlVxWUhWbmNjSUNOdGR6by92SGNTZUUwUXNKK2grN0VHL3hpUE5sU1BPQldD?=
 =?utf-8?B?WWZaZnhRTUM1L1BLVkluaDRSVUQwNlhvOVZlVXhSdG9DZ0RmTGhCSkZDMFlv?=
 =?utf-8?B?M000RjIxa2dmYkFnR1pwQXp2TWdGSkZkdXlaQnJLWWdpNUtGWHVJRytmMjRr?=
 =?utf-8?B?UFA3UXNjY3o1a0FPUXExUVBYbzhvcnJPK1d2TzVZak5pS3RlWmtNOGJEZXdn?=
 =?utf-8?B?OUpqb043aUlsNW85d3J4eHdSUXFkbnlOSXBqUlpDQTIrUmt4WSswcngyb0NZ?=
 =?utf-8?B?bEJiYWdTL0d5ZzJWL3NNYXhLMGJYZlBJRElBRVduMUNNdWZBZXpVMmNxN0cx?=
 =?utf-8?B?T2puck9kMHZ1enVUQUhobzRFaldxNUlQUUlxazQ4NG9Pb3V4b0oxcFdhN1Fo?=
 =?utf-8?B?LzA1RGYzYitReEVtZitWaU5iRm9mcFYvUWJyMTlIWFN4U2E1L1VKSmM2dURZ?=
 =?utf-8?B?QnZiSC9OeWlkY1dacUhSZjU2bXpFK3lmVmNET0pmRTVhVE5KUmsyYUJTZ1Zu?=
 =?utf-8?B?NVRTVHNya1E5cTlHNWxBY1JTbis2OEVzQ1hrKzhwQnlQMDlUYVNwN3hCemYx?=
 =?utf-8?B?cFRiQ3p0VDMrdjFhTG5tL2VQS1grbXhkV1dwSFpEQVN6azFTbUxBVGhtdlJm?=
 =?utf-8?B?QkFCOXd2MGZjUlVSSStxZHB1bnBUbTYrTDNHREVVTTcraG15MWhkY3MwMjBD?=
 =?utf-8?B?bjZaaTJYYzJxSFY0b1Y0VnBPZE1oSTVLRXpkVnFSVFhMWDlKTEFsek5KcUI4?=
 =?utf-8?B?VkV2bjJSZ0RYNkFFSEN1UXk1OGFITjYxL05TNC9Ub2RoZTZUMjVHSmF4a0F4?=
 =?utf-8?B?RnhRbm1HQ0VROEs0bHdJTlVPa0x5YStJT25HYzNxM2UveHRQbWRkNEZFTEZM?=
 =?utf-8?B?VWxhZjJORWhCZ2ViT3V5VWFrTUlLRnN3Sll2T2xjL1B0YmxoeHVrbHM2Ymtt?=
 =?utf-8?B?UzJzNEZEY2FGTVdtaUkzSUlTbjFPMjNpeTN0U0Iwc25XY0FtQ0RqcUx5bjhX?=
 =?utf-8?B?QkJLM3RBbE1IaTRHZkxWTURSWEZla2VMc0NrWVR6WWYzN2JXSk5pUG8wc0hW?=
 =?utf-8?B?VEhLNHFmeGtPUzUwYmRrMVA3RURUQnNQR0RIYnVVTVVROEw2Si9lay9LcEkz?=
 =?utf-8?B?QWtvVDdiTDRHVlpka29IZ2JOcDJubTlFd3d2WnBFRForWE1wZWpGUldnTVBL?=
 =?utf-8?B?OTIrODVwSXYxVW5wQUxJOVV4eTRpUGc3N1Y2MnlhQzM5Q1oybFRrMGI3SjF2?=
 =?utf-8?B?SDc2ZVJkOUl6emlPK005L1V2azkrVnBjSG9BTEpodm82TEx6NzUvaFliNElY?=
 =?utf-8?B?N2hWSXg1WW10TGU5RU1TSnNWS3Bid2YwZGQ3TG8wMGc5OS9KRkFJR1lDZDRr?=
 =?utf-8?B?dlJjNWpNNG5TbU5TZXhIZGtxNFZDNFdQMGx2ai9wNTZ5VTVMYUxGS3JQYllD?=
 =?utf-8?B?Rmc9PQ==?=
X-OriginatorOrg: kontron.de
X-MS-Exchange-CrossTenant-Network-Message-Id: cd1319f6-589f-4eb5-bb99-08dccce6759d
X-MS-Exchange-CrossTenant-AuthSource: PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2024 13:35:36.8755
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XV1vyCUnPgBufZZGVv7u4vQRisHfTIdPCwzShPSgfBvL6blzawhp0dIkYwNGvfuILsoxAOPlCkNn4W/khiKM4CNDQi2MtRsLFLZzP+NfHaA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB7922

On 04.09.24 4:32 AM, Adam Ford wrote:
> There is currently a look-up table for a variety of resolutions.
> Since the phy has the ability to dynamically calculate the values
> necessary to use the intger divider which should allow more

                       ^ integer

> resolutions without having to update the look-up-table.
> 
> If the lookup table cannot find an exact match, fall back to the
> dynamic calculator of the integer divider.

Nitpick: You have thre different versions of how to spell "lookup table"
in the paragraphs above. Maybe you can decide on one... ;)

> 
> Previously, the value of P was hard-coded to 1, this required an
> update to the phy_pll_cfg table to add in the extra value into the
> table, so if the value of P is calculated to be something else
> by the PMS calculator, the calculated_phy_pll_cfg structure
> can be used instead without having to keep track of which method
> was used.
> 
> Signed-off-by: Adam Ford <aford173@gmail.com>

The comments I have are only nitpicks and the patch seems to work fine
for me. So feel free to add:

Reviewed-by: Frieder Schrempf <frieder.schrempf@kontron.de>
Tested-by: Frieder Schrempf <frieder.schrempf@kontron.de>

> ---
> V5:  No Change
> V4:  No Change
> V3:  Change size of pll_div_regs to include PHY_REG01 (P)
>      Create calculated_phy_pll_cfg to containe the values
>      Eliminate the PMS calculation from fsl_samsung_hdmi_phy_configure
>      Make the LUT primary and fall back to integer calculator in
>      phy_clk_round_rate.
>      Check the range right away to ensure it's reaonsable rather than
>      trying to find a clock only to learn it's outside the range.
>      Overall added notes and comments where stuff may not be intuitive.
> 
> V2:  Update phy_clk_round_rate and phy_clk_set_rate to both support
>      the integer clock PMS calculator.
> ---
>  drivers/phy/freescale/phy-fsl-samsung-hdmi.c | 341 +++++++++++++------
>  1 file changed, 235 insertions(+), 106 deletions(-)
> 
> diff --git a/drivers/phy/freescale/phy-fsl-samsung-hdmi.c b/drivers/phy/freescale/phy-fsl-samsung-hdmi.c
> index 4f6874226f9a..8f2c0082aa12 100644
> --- a/drivers/phy/freescale/phy-fsl-samsung-hdmi.c
> +++ b/drivers/phy/freescale/phy-fsl-samsung-hdmi.c
> @@ -16,6 +16,8 @@
>  
>  #define PHY_REG(reg)		(reg * 4)
>  
> +#define REG01_PMS_P_MASK	GENMASK(3, 0)
> +#define REG03_PMS_S_MASK	GENMASK(7, 4)
>  #define REG12_CK_DIV_MASK	GENMASK(5, 4)
>  
>  #define REG13_TG_CODE_LOW_MASK	GENMASK(7, 0)
> @@ -38,281 +40,296 @@
>  #define REG34_PLL_LOCK		BIT(6)
>  #define REG34_PHY_CLK_READY	BIT(5)
>  
> -#define PHY_PLL_DIV_REGS_NUM 6
> +#ifndef MHZ
> +#define MHZ	(1000UL * 1000UL)
> +#endif
> +
> +#define PHY_PLL_DIV_REGS_NUM 7
>  
>  struct phy_config {
>  	u32	pixclk;
>  	u8	pll_div_regs[PHY_PLL_DIV_REGS_NUM];
>  };
>  
> +/*
> + * The calculated_phy_pll_cfg only handles integer divider for PMS only,

Nitpick: Remove duplicate 'only'

> + * meaning the last four entries will be fixed, but the first three will
> + * be calculated by the PMS calculator

Nitpick: Period at the end of the sentence

> + */
> +static struct phy_config calculated_phy_pll_cfg = {
> +	.pixclk = 0,
> +	.pll_div_regs = { 0x00, 0x00, 0x00, 0x00, 0x00, 0x80, 0x00 },
> +};
> +
> +/* The lookup table contains values for which the fractional divder is used */

Nitpick: It seems this comment would rather belong into patch 5/5.

>  static const struct phy_config phy_pll_cfg[] = {
>  	{
>  		.pixclk = 22250000,
> -		.pll_div_regs = { 0x4b, 0xf1, 0x89, 0x88, 0x80, 0x40 },
> +		.pll_div_regs = { 0xd1, 0x4b, 0xf1, 0x89, 0x88, 0x80, 0x40 },
>  	}, {
>  		.pixclk = 23750000,
> -		.pll_div_regs = { 0x50, 0xf1, 0x86, 0x85, 0x80, 0x40 },
> +		.pll_div_regs = { 0xd1, 0x50, 0xf1, 0x86, 0x85, 0x80, 0x40 },
>  	}, {
>  		.pixclk = 24000000,
> -		.pll_div_regs = { 0x50, 0xf0, 0x00, 0x00, 0x80, 0x00 },
> +		.pll_div_regs = { 0xd1, 0x50, 0xf0, 0x00, 0x00, 0x80, 0x00 },
>  	}, {
>  		.pixclk = 24024000,
> -		.pll_div_regs = { 0x50, 0xf1, 0x99, 0x02, 0x80, 0x40 },
> +		.pll_div_regs = { 0xd1, 0x50, 0xf1, 0x99, 0x02, 0x80, 0x40 },
>  	}, {
>  		.pixclk = 25175000,
> -		.pll_div_regs = { 0x54, 0xfc, 0xcc, 0x91, 0x80, 0x40 },
> +		.pll_div_regs = { 0xd1, 0x54, 0xfc, 0xcc, 0x91, 0x80, 0x40 },
>  	}, {
>  		.pixclk = 25200000,
> -		.pll_div_regs = { 0x54, 0xf0, 0x00, 0x00, 0x80, 0x00 },
> +		.pll_div_regs = { 0xd1, 0x54, 0xf0, 0x00, 0x00, 0x80, 0x00 },
>  	}, {
>  		.pixclk = 26750000,
> -		.pll_div_regs = { 0x5a, 0xf2, 0x89, 0x88, 0x80, 0x40 },
> +		.pll_div_regs = { 0xd1, 0x5a, 0xf2, 0x89, 0x88, 0x80, 0x40 },
>  	}, {
>  		.pixclk = 27000000,
> -		.pll_div_regs = { 0x5a, 0xf0, 0x00, 0x00, 0x80, 0x00 },
> +		.pll_div_regs = { 0xd1, 0x5a, 0xf0, 0x00, 0x00, 0x80, 0x00 },
>  	}, {
>  		.pixclk = 27027000,
> -		.pll_div_regs = { 0x5a, 0xf2, 0xfd, 0x0c, 0x80, 0x40 },
> +		.pll_div_regs = { 0xd1, 0x5a, 0xf2, 0xfd, 0x0c, 0x80, 0x40 },
>  	}, {
>  		.pixclk = 29500000,
> -		.pll_div_regs = { 0x62, 0xf4, 0x95, 0x08, 0x80, 0x40 },
> +		.pll_div_regs = { 0xd1, 0x62, 0xf4, 0x95, 0x08, 0x80, 0x40 },
>  	}, {
>  		.pixclk = 30750000,
> -		.pll_div_regs = { 0x66, 0xf4, 0x82, 0x01, 0x88, 0x45 },
> +		.pll_div_regs = { 0xd1, 0x66, 0xf4, 0x82, 0x01, 0x88, 0x45 },
>  	}, {
>  		.pixclk = 30888000,
> -		.pll_div_regs = { 0x66, 0xf4, 0x99, 0x18, 0x88, 0x45 },
> +		.pll_div_regs = { 0xd1, 0x66, 0xf4, 0x99, 0x18, 0x88, 0x45 },
>  	}, {
>  		.pixclk = 33750000,
> -		.pll_div_regs = { 0x70, 0xf4, 0x82, 0x01, 0x80, 0x40 },
> +		.pll_div_regs = { 0xd1, 0x70, 0xf4, 0x82, 0x01, 0x80, 0x40 },
>  	}, {
>  		.pixclk = 35000000,
> -		.pll_div_regs = { 0x58, 0xb8, 0x8b, 0x88, 0x80, 0x40 },
> +		.pll_div_regs = { 0xd1, 0x58, 0xb8, 0x8b, 0x88, 0x80, 0x40 },
>  	}, {
>  		.pixclk = 36000000,
> -		.pll_div_regs = { 0x5a, 0xb0, 0x00, 0x00, 0x80, 0x00 },
> +		.pll_div_regs = { 0xd1, 0x5a, 0xb0, 0x00, 0x00, 0x80, 0x00 },
>  	}, {
>  		.pixclk = 36036000,
> -		.pll_div_regs = { 0x5a, 0xb2, 0xfd, 0x0c, 0x80, 0x40 },
> +		.pll_div_regs = { 0xd1, 0x5a, 0xb2, 0xfd, 0x0c, 0x80, 0x40 },
>  	}, {
>  		.pixclk = 40000000,
> -		.pll_div_regs = { 0x64, 0xb0, 0x00, 0x00, 0x80, 0x00 },
> +		.pll_div_regs = { 0xd1, 0x64, 0xb0, 0x00, 0x00, 0x80, 0x00 },
>  	}, {
>  		.pixclk = 43200000,
> -		.pll_div_regs = { 0x5a, 0x90, 0x00, 0x00, 0x80, 0x00 },
> +		.pll_div_regs = { 0xd1, 0x5a, 0x90, 0x00, 0x00, 0x80, 0x00 },
>  	}, {
>  		.pixclk = 43243200,
> -		.pll_div_regs = { 0x5a, 0x92, 0xfd, 0x0c, 0x80, 0x40 },
> +		.pll_div_regs = { 0xd1, 0x5a, 0x92, 0xfd, 0x0c, 0x80, 0x40 },
>  	}, {
>  		.pixclk = 44500000,
> -		.pll_div_regs = { 0x5c, 0x92, 0x98, 0x11, 0x84, 0x41 },
> +		.pll_div_regs = { 0xd1, 0x5c, 0x92, 0x98, 0x11, 0x84, 0x41 },
>  	}, {
>  		.pixclk = 47000000,
> -		.pll_div_regs = { 0x62, 0x94, 0x95, 0x82, 0x80, 0x40 },
> +		.pll_div_regs = { 0xd1, 0x62, 0x94, 0x95, 0x82, 0x80, 0x40 },
>  	}, {
>  		.pixclk = 47500000,
> -		.pll_div_regs = { 0x63, 0x96, 0xa1, 0x82, 0x80, 0x40 },
> +		.pll_div_regs = { 0xd1, 0x63, 0x96, 0xa1, 0x82, 0x80, 0x40 },
>  	}, {
>  		.pixclk = 50349650,
> -		.pll_div_regs = { 0x54, 0x7c, 0xc3, 0x8f, 0x80, 0x40 },
> +		.pll_div_regs = { 0xd1, 0x54, 0x7c, 0xc3, 0x8f, 0x80, 0x40 },
>  	}, {
>  		.pixclk = 50400000,
> -		.pll_div_regs = { 0x54, 0x70, 0x00, 0x00, 0x80, 0x00 },
> +		.pll_div_regs = { 0xd1, 0x54, 0x70, 0x00, 0x00, 0x80, 0x00 },
>  	}, {
>  		.pixclk = 53250000,
> -		.pll_div_regs = { 0x58, 0x72, 0x84, 0x03, 0x82, 0x41 },
> +		.pll_div_regs = { 0xd1, 0x58, 0x72, 0x84, 0x03, 0x82, 0x41 },
>  	}, {
>  		.pixclk = 53500000,
> -		.pll_div_regs = { 0x5a, 0x72, 0x89, 0x88, 0x80, 0x40 },
> +		.pll_div_regs = { 0xd1, 0x5a, 0x72, 0x89, 0x88, 0x80, 0x40 },
>  	}, {
>  		.pixclk = 54000000,
> -		.pll_div_regs = { 0x5a, 0x70, 0x00, 0x00, 0x80, 0x00 },
> +		.pll_div_regs = { 0xd1, 0x5a, 0x70, 0x00, 0x00, 0x80, 0x00 },
>  	}, {
>  		.pixclk = 54054000,
> -		.pll_div_regs = { 0x5a, 0x72, 0xfd, 0x0c, 0x80, 0x40 },
> +		.pll_div_regs = { 0xd1, 0x5a, 0x72, 0xfd, 0x0c, 0x80, 0x40 },
>  	}, {
>  		.pixclk = 59000000,
> -		.pll_div_regs = { 0x62, 0x74, 0x95, 0x08, 0x80, 0x40 },
> +		.pll_div_regs = { 0xd1, 0x62, 0x74, 0x95, 0x08, 0x80, 0x40 },
>  	}, {
>  		.pixclk = 59340659,
> -		.pll_div_regs = { 0x62, 0x74, 0xdb, 0x52, 0x88, 0x47 },
> +		.pll_div_regs = { 0xd1, 0x62, 0x74, 0xdb, 0x52, 0x88, 0x47 },
>  	}, {
>  		.pixclk = 59400000,
> -		.pll_div_regs = { 0x63, 0x70, 0x00, 0x00, 0x80, 0x00 },
> +		.pll_div_regs = { 0xd1, 0x63, 0x70, 0x00, 0x00, 0x80, 0x00 },
>  	}, {
>  		.pixclk = 61500000,
> -		.pll_div_regs = { 0x66, 0x74, 0x82, 0x01, 0x88, 0x45 },
> +		.pll_div_regs = { 0xd1, 0x66, 0x74, 0x82, 0x01, 0x88, 0x45 },
>  	}, {
>  		.pixclk = 63500000,
> -		.pll_div_regs = { 0x69, 0x74, 0x89, 0x08, 0x80, 0x40 },
> +		.pll_div_regs = { 0xd1, 0x69, 0x74, 0x89, 0x08, 0x80, 0x40 },
>  	}, {
>  		.pixclk = 67500000,
> -		.pll_div_regs = { 0x54, 0x52, 0x87, 0x03, 0x80, 0x40 },
> +		.pll_div_regs = { 0xd1, 0x54, 0x52, 0x87, 0x03, 0x80, 0x40 },
>  	}, {
>  		.pixclk = 70000000,
> -		.pll_div_regs = { 0x58, 0x58, 0x8b, 0x88, 0x80, 0x40 },
> +		.pll_div_regs = { 0xd1, 0x58, 0x58, 0x8b, 0x88, 0x80, 0x40 },
>  	}, {
>  		.pixclk = 72000000,
> -		.pll_div_regs = { 0x5a, 0x50, 0x00, 0x00, 0x80, 0x00 },
> +		.pll_div_regs = { 0xd1, 0x5a, 0x50, 0x00, 0x00, 0x80, 0x00 },
>  	}, {
>  		.pixclk = 72072000,
> -		.pll_div_regs = { 0x5a, 0x52, 0xfd, 0x0c, 0x80, 0x40 },
> +		.pll_div_regs = { 0xd1, 0x5a, 0x52, 0xfd, 0x0c, 0x80, 0x40 },
>  	}, {
>  		.pixclk = 74176000,
> -		.pll_div_regs = { 0x5d, 0x58, 0xdb, 0xA2, 0x88, 0x41 },
> +		.pll_div_regs = { 0xd1, 0x5d, 0x58, 0xdb, 0xA2, 0x88, 0x41 },
>  	}, {
>  		.pixclk = 74250000,
> -		.pll_div_regs = { 0x5c, 0x52, 0x90, 0x0d, 0x84, 0x41 },
> +		.pll_div_regs = { 0xd1, 0x5c, 0x52, 0x90, 0x0d, 0x84, 0x41 },
>  	}, {
>  		.pixclk = 78500000,
> -		.pll_div_regs = { 0x62, 0x54, 0x87, 0x01, 0x80, 0x40 },
> +		.pll_div_regs = { 0xd1, 0x62, 0x54, 0x87, 0x01, 0x80, 0x40 },
>  	}, {
>  		.pixclk = 80000000,
> -		.pll_div_regs = { 0x64, 0x50, 0x00, 0x00, 0x80, 0x00 },
> +		.pll_div_regs = { 0xd1, 0x64, 0x50, 0x00, 0x00, 0x80, 0x00 },
>  	}, {
>  		.pixclk = 82000000,
> -		.pll_div_regs = { 0x66, 0x54, 0x82, 0x01, 0x88, 0x45 },
> +		.pll_div_regs = { 0xd1, 0x66, 0x54, 0x82, 0x01, 0x88, 0x45 },
>  	}, {
>  		.pixclk = 82500000,
> -		.pll_div_regs = { 0x67, 0x54, 0x88, 0x01, 0x90, 0x49 },
> +		.pll_div_regs = { 0xd1, 0x67, 0x54, 0x88, 0x01, 0x90, 0x49 },
>  	}, {
>  		.pixclk = 89000000,
> -		.pll_div_regs = { 0x70, 0x54, 0x84, 0x83, 0x80, 0x40 },
> +		.pll_div_regs = { 0xd1, 0x70, 0x54, 0x84, 0x83, 0x80, 0x40 },
>  	}, {
>  		.pixclk = 90000000,
> -		.pll_div_regs = { 0x70, 0x54, 0x82, 0x01, 0x80, 0x40 },
> +		.pll_div_regs = { 0xd1, 0x70, 0x54, 0x82, 0x01, 0x80, 0x40 },
>  	}, {
>  		.pixclk = 94000000,
> -		.pll_div_regs = { 0x4e, 0x32, 0xa7, 0x10, 0x80, 0x40 },
> +		.pll_div_regs = { 0xd1, 0x4e, 0x32, 0xa7, 0x10, 0x80, 0x40 },
>  	}, {
>  		.pixclk = 95000000,
> -		.pll_div_regs = { 0x50, 0x31, 0x86, 0x85, 0x80, 0x40 },
> +		.pll_div_regs = { 0xd1, 0x50, 0x31, 0x86, 0x85, 0x80, 0x40 },
>  	}, {
>  		.pixclk = 98901099,
> -		.pll_div_regs = { 0x52, 0x3a, 0xdb, 0x4c, 0x88, 0x47 },
> +		.pll_div_regs = { 0xd1, 0x52, 0x3a, 0xdb, 0x4c, 0x88, 0x47 },
>  	}, {
>  		.pixclk = 99000000,
> -		.pll_div_regs = { 0x52, 0x32, 0x82, 0x01, 0x88, 0x47 },
> +		.pll_div_regs = { 0xd1, 0x52, 0x32, 0x82, 0x01, 0x88, 0x47 },
>  	}, {
>  		.pixclk = 100699300,
> -		.pll_div_regs = { 0x54, 0x3c, 0xc3, 0x8f, 0x80, 0x40 },
> +		.pll_div_regs = { 0xd1, 0x54, 0x3c, 0xc3, 0x8f, 0x80, 0x40 },
>  	}, {
>  		.pixclk = 100800000,
> -		.pll_div_regs = { 0x54, 0x30, 0x00, 0x00, 0x80, 0x00 },
> +		.pll_div_regs = { 0xd1, 0x54, 0x30, 0x00, 0x00, 0x80, 0x00 },
>  	}, {
>  		.pixclk = 102500000,
> -		.pll_div_regs = { 0x55, 0x32, 0x8c, 0x05, 0x90, 0x4b },
> +		.pll_div_regs = { 0xd1, 0x55, 0x32, 0x8c, 0x05, 0x90, 0x4b },
>  	}, {
>  		.pixclk = 104750000,
> -		.pll_div_regs = { 0x57, 0x32, 0x98, 0x07, 0x90, 0x49 },
> +		.pll_div_regs = { 0xd1, 0x57, 0x32, 0x98, 0x07, 0x90, 0x49 },
>  	}, {
>  		.pixclk = 106500000,
> -		.pll_div_regs = { 0x58, 0x32, 0x84, 0x03, 0x82, 0x41 },
> +		.pll_div_regs = { 0xd1, 0x58, 0x32, 0x84, 0x03, 0x82, 0x41 },
>  	}, {
>  		.pixclk = 107000000,
> -		.pll_div_regs = { 0x5a, 0x32, 0x89, 0x88, 0x80, 0x40 },
> +		.pll_div_regs = { 0xd1, 0x5a, 0x32, 0x89, 0x88, 0x80, 0x40 },
>  	}, {
>  		.pixclk = 108000000,
> -		.pll_div_regs = { 0x5a, 0x30, 0x00, 0x00, 0x80, 0x00 },
> +		.pll_div_regs = { 0xd1, 0x5a, 0x30, 0x00, 0x00, 0x80, 0x00 },
>  	}, {
>  		.pixclk = 108108000,
> -		.pll_div_regs = { 0x5a, 0x32, 0xfd, 0x0c, 0x80, 0x40 },
> +		.pll_div_regs = { 0xd1, 0x5a, 0x32, 0xfd, 0x0c, 0x80, 0x40 },
>  	}, {
>  		.pixclk = 118000000,
> -		.pll_div_regs = { 0x62, 0x34, 0x95, 0x08, 0x80, 0x40 },
> +		.pll_div_regs = { 0xd1, 0x62, 0x34, 0x95, 0x08, 0x80, 0x40 },
>  	}, {
>  		.pixclk = 118800000,
> -		.pll_div_regs = { 0x63, 0x30, 0x00, 0x00, 0x80, 0x00 },
> +		.pll_div_regs = { 0xd1, 0x63, 0x30, 0x00, 0x00, 0x80, 0x00 },
>  	}, {
>  		.pixclk = 123000000,
> -		.pll_div_regs = { 0x66, 0x34, 0x82, 0x01, 0x88, 0x45 },
> +		.pll_div_regs = { 0xd1, 0x66, 0x34, 0x82, 0x01, 0x88, 0x45 },
>  	}, {
>  		.pixclk = 127000000,
> -		.pll_div_regs = { 0x69, 0x34, 0x89, 0x08, 0x80, 0x40 },
> +		.pll_div_regs = { 0xd1, 0x69, 0x34, 0x89, 0x08, 0x80, 0x40 },
>  	}, {
>  		.pixclk = 135000000,
> -		.pll_div_regs = { 0x70, 0x34, 0x82, 0x01, 0x80, 0x40 },
> +		.pll_div_regs = { 0xd1, 0x70, 0x34, 0x82, 0x01, 0x80, 0x40 },
>  	}, {
>  		.pixclk = 135580000,
> -		.pll_div_regs = { 0x71, 0x39, 0xe9, 0x82, 0x9c, 0x5b },
> +		.pll_div_regs = { 0xd1, 0x71, 0x39, 0xe9, 0x82, 0x9c, 0x5b },
>  	}, {
>  		.pixclk = 137520000,
> -		.pll_div_regs = { 0x72, 0x38, 0x99, 0x10, 0x85, 0x41 },
> +		.pll_div_regs = { 0xd1, 0x72, 0x38, 0x99, 0x10, 0x85, 0x41 },
>  	}, {
>  		.pixclk = 138750000,
> -		.pll_div_regs = { 0x73, 0x35, 0x88, 0x05, 0x90, 0x4d },
> +		.pll_div_regs = { 0xd1, 0x73, 0x35, 0x88, 0x05, 0x90, 0x4d },
>  	}, {
>  		.pixclk = 140000000,
> -		.pll_div_regs = { 0x75, 0x36, 0xa7, 0x90, 0x80, 0x40 },
> +		.pll_div_regs = { 0xd1, 0x75, 0x36, 0xa7, 0x90, 0x80, 0x40 },
>  	}, {
>  		.pixclk = 144000000,
> -		.pll_div_regs = { 0x78, 0x30, 0x00, 0x00, 0x80, 0x00 },
> +		.pll_div_regs = { 0xd1, 0x78, 0x30, 0x00, 0x00, 0x80, 0x00 },
>  	}, {
>  		.pixclk = 148352000,
> -		.pll_div_regs = { 0x7b, 0x35, 0xdb, 0x39, 0x90, 0x45 },
> +		.pll_div_regs = { 0xd1, 0x7b, 0x35, 0xdb, 0x39, 0x90, 0x45 },
>  	}, {
>  		.pixclk = 148500000,
> -		.pll_div_regs = { 0x7b, 0x35, 0x84, 0x03, 0x90, 0x45 },
> +		.pll_div_regs = { 0xd1, 0x7b, 0x35, 0x84, 0x03, 0x90, 0x45 },
>  	}, {
>  		.pixclk = 154000000,
> -		.pll_div_regs = { 0x40, 0x18, 0x83, 0x01, 0x00, 0x40 },
> +		.pll_div_regs = { 0xd1, 0x40, 0x18, 0x83, 0x01, 0x00, 0x40 },
>  	}, {
>  		.pixclk = 157000000,
> -		.pll_div_regs = { 0x41, 0x11, 0xa7, 0x14, 0x80, 0x40 },
> +		.pll_div_regs = { 0xd1, 0x41, 0x11, 0xa7, 0x14, 0x80, 0x40 },
>  	}, {
>  		.pixclk = 160000000,
> -		.pll_div_regs = { 0x42, 0x12, 0xa1, 0x20, 0x80, 0x40 },
> +		.pll_div_regs = { 0xd1, 0x42, 0x12, 0xa1, 0x20, 0x80, 0x40 },
>  	}, {
>  		.pixclk = 162000000,
> -		.pll_div_regs = { 0x43, 0x18, 0x8b, 0x08, 0x96, 0x55 },
> +		.pll_div_regs = { 0xd1, 0x43, 0x18, 0x8b, 0x08, 0x96, 0x55 },
>  	}, {
>  		.pixclk = 164000000,
> -		.pll_div_regs = { 0x45, 0x11, 0x83, 0x82, 0x90, 0x4b },
> +		.pll_div_regs = { 0xd1, 0x45, 0x11, 0x83, 0x82, 0x90, 0x4b },
>  	}, {
>  		.pixclk = 165000000,
> -		.pll_div_regs = { 0x45, 0x11, 0x84, 0x81, 0x90, 0x4b },
> +		.pll_div_regs = { 0xd1, 0x45, 0x11, 0x84, 0x81, 0x90, 0x4b },
>  	}, {
>  		.pixclk = 180000000,
> -		.pll_div_regs = { 0x4b, 0x10, 0x00, 0x00, 0x80, 0x00 },
> +		.pll_div_regs = { 0xd1, 0x4b, 0x10, 0x00, 0x00, 0x80, 0x00 },
>  	}, {
>  		.pixclk = 185625000,
> -		.pll_div_regs = { 0x4e, 0x12, 0x9a, 0x95, 0x80, 0x40 },
> +		.pll_div_regs = { 0xd1, 0x4e, 0x12, 0x9a, 0x95, 0x80, 0x40 },
>  	}, {
>  		.pixclk = 188000000,
> -		.pll_div_regs = { 0x4e, 0x12, 0xa7, 0x10, 0x80, 0x40 },
> +		.pll_div_regs = { 0xd1, 0x4e, 0x12, 0xa7, 0x10, 0x80, 0x40 },
>  	}, {
>  		.pixclk = 198000000,
> -		.pll_div_regs = { 0x52, 0x12, 0x82, 0x01, 0x88, 0x47 },
> +		.pll_div_regs = { 0xd1, 0x52, 0x12, 0x82, 0x01, 0x88, 0x47 },
>  	}, {
>  		.pixclk = 205000000,
> -		.pll_div_regs = { 0x55, 0x12, 0x8c, 0x05, 0x90, 0x4b },
> +		.pll_div_regs = { 0xd1, 0x55, 0x12, 0x8c, 0x05, 0x90, 0x4b },
>  	}, {
>  		.pixclk = 209500000,
> -		.pll_div_regs = { 0x57, 0x12, 0x98, 0x07, 0x90, 0x49 },
> +		.pll_div_regs = { 0xd1, 0x57, 0x12, 0x98, 0x07, 0x90, 0x49 },
>  	}, {
>  		.pixclk = 213000000,
> -		.pll_div_regs = { 0x58, 0x12, 0x84, 0x03, 0x82, 0x41 },
> +		.pll_div_regs = { 0xd1, 0x58, 0x12, 0x84, 0x03, 0x82, 0x41 },
>  	}, {
>  		.pixclk = 216000000,
> -		.pll_div_regs = { 0x5a, 0x10, 0x00, 0x00, 0x80, 0x00 },
> +		.pll_div_regs = { 0xd1, 0x5a, 0x10, 0x00, 0x00, 0x80, 0x00 },
>  	}, {
>  		.pixclk = 216216000,
> -		.pll_div_regs = { 0x5a, 0x12, 0xfd, 0x0c, 0x80, 0x40 },
> +		.pll_div_regs = { 0xd1, 0x5a, 0x12, 0xfd, 0x0c, 0x80, 0x40 },
>  	}, {
>  		.pixclk = 237600000,
> -		.pll_div_regs = { 0x63, 0x10, 0x00, 0x00, 0x80, 0x00 },
> +		.pll_div_regs = { 0xd1, 0x63, 0x10, 0x00, 0x00, 0x80, 0x00 },
>  	}, {
>  		.pixclk = 254000000,
> -		.pll_div_regs = { 0x69, 0x14, 0x89, 0x08, 0x80, 0x40 },
> +		.pll_div_regs = { 0xd1, 0x69, 0x14, 0x89, 0x08, 0x80, 0x40 },
>  	}, {
>  		.pixclk = 277500000,
> -		.pll_div_regs = { 0x73, 0x15, 0x88, 0x05, 0x90, 0x4d },
> +		.pll_div_regs = { 0xd1, 0x73, 0x15, 0x88, 0x05, 0x90, 0x4d },
>  	}, {
>  		.pixclk = 288000000,
> -		.pll_div_regs = { 0x78, 0x10, 0x00, 0x00, 0x80, 0x00 },
> +		.pll_div_regs = { 0xd1, 0x78, 0x10, 0x00, 0x00, 0x80, 0x00 },
>  	}, {
>  		.pixclk = 297000000,
> -		.pll_div_regs = { 0x7b, 0x15, 0x84, 0x03, 0x90, 0x45 },
> +		.pll_div_regs = { 0xd1, 0x7b, 0x15, 0x84, 0x03, 0x90, 0x45 },
>  	},
>  };
>  
> @@ -322,7 +339,8 @@ struct reg_settings {
>  };
>  
>  static const struct reg_settings common_phy_cfg[] = {
> -	{ PHY_REG(0), 0x00 }, { PHY_REG(1), 0xd1 },
> +	{ PHY_REG(0), 0x00 },
> +	/* PHY_REG(1-7) pix clk specific */
>  	{ PHY_REG(8), 0x4f }, { PHY_REG(9), 0x30 },
>  	{ PHY_REG(10), 0x33 }, { PHY_REG(11), 0x65 },
>  	/* REG12 pixclk specific */
> @@ -415,6 +433,76 @@ fsl_samsung_hdmi_phy_configure_pll_lock_det(struct fsl_samsung_hdmi_phy *phy,
>  	       phy->regs + PHY_REG(14));
>  }
>  
> +static unsigned long fsl_samsung_hdmi_phy_find_pms(unsigned long fout, u8 *p, u16 *m, u8 *s)
> +{
> +	unsigned long best_freq = 0;
> +	u32 min_delta = 0xffffffff;
> +	u8 _p, best_p;
> +	u16 _m, best_m;
> +	u8 _s, best_s;
> +
> +	/* The ref manual states the values of 'P' range from 1 to 11 */
> +	for (_p = 1; _p <= 11; ++_p) {
> +		for (_s = 1; _s <= 16; ++_s) {
> +			u64 tmp;
> +			u32 delta;
> +
> +			/* s must be one or even */
> +			if (_s > 1 && (_s & 0x01) == 1)
> +				_s++;
> +
> +			/* _s cannot be 14 per the TRM */
> +			if (_s == 14)
> +				continue;
> +
> +			/*
> +			 * TODO: Ref Manual doesn't state the range of _m
> +			 * so this should be further refined if possible.
> +			 * This range was set based on the original values
> +			 * in the look-up table
> +			 */

There is the strange note "Div by -Div by 255" in the RM. I think it's
supposed to define the range, but is missing the number for the lower
bound. The upper bound is probably 255!?

But we might also leave it like it is here and extend it later after
further testing.

> +			tmp = (u64)fout * (_p * _s);
> +			do_div(tmp, 24 * MHZ);
> +			_m = tmp;
> +			if (_m < 0x30 || _m > 0x7b)
> +				continue;
> +
> +			/*
> +			 * Rev 2 of the Ref Manual states the
> +			 * VCO can range between 750MHz and
> +			 * 3GHz.  The VCO is assumed to be _m x
> +			 * the reference frequency of 24MHz divided
> +			 * by the prescaler, _p

Maybe better: "The VSO is assumed to be (M * f_ref) / P"

> +			 */
> +			tmp = (u64)_m * 24 * MHZ;
> +			do_div(tmp, _p);
> +			if (tmp < 750 * MHZ ||
> +			    tmp > 3000 * MHZ)
> +				continue;
> +
> +			tmp = (u64)_m * 24 * MHZ;
> +			do_div(tmp, _p * _s);

tmp already contains (_m * f_ref) / _p, so we sould be able to reuse
that value here and simply do do_div(tmp, _s) without recalculating tmp, no?

> +
> +			delta = abs(fout - tmp);
> +			if (delta < min_delta) {
> +				best_p = _p;
> +				best_s = _s;
> +				best_m = _m;
> +				min_delta = delta;
> +				best_freq = tmp;
> +			}
> +		}
> +	}
> +
> +	if (best_freq) {
> +		*p = best_p;
> +		*m = best_m;
> +		*s = best_s;
> +	}
> +
> +	return best_freq;
> +}
> +
>  static int fsl_samsung_hdmi_phy_configure(struct fsl_samsung_hdmi_phy *phy,
>  					  const struct phy_config *cfg)
>  {
> @@ -428,13 +516,13 @@ static int fsl_samsung_hdmi_phy_configure(struct fsl_samsung_hdmi_phy *phy,
>  	for (i = 0; i < ARRAY_SIZE(common_phy_cfg); i++)
>  		writeb(common_phy_cfg[i].val, phy->regs + common_phy_cfg[i].reg);
>  
> -	/* set individual PLL registers PHY_REG2 ... PHY_REG7 */
> +	/* set individual PLL registers PHY_REG1 ... PHY_REG7 */
>  	for (i = 0; i < PHY_PLL_DIV_REGS_NUM; i++)
> -		writeb(cfg->pll_div_regs[i], phy->regs + PHY_REG(2) + i * 4);
> +		writeb(cfg->pll_div_regs[i], phy->regs + PHY_REG(1) + i * 4);
>  
> -	/* High nibble of pll_div_regs[1] contains S which also gets written to REG21 */
> +	/* High nibble of PHY_REG3 and low nibble of PHY_REG21 both contain 'S' */
>  	writeb(REG21_SEL_TX_CK_INV | FIELD_PREP(REG21_PMS_S_MASK,
> -	       cfg->pll_div_regs[1] >> 4), phy->regs + PHY_REG(21));
> +	       cfg->pll_div_regs[2] >> 4), phy->regs + PHY_REG(21));
>  
>  	fsl_samsung_hdmi_phy_configure_pll_lock_det(phy, cfg);
>  
> @@ -462,29 +550,70 @@ static unsigned long phy_clk_recalc_rate(struct clk_hw *hw,
>  static long phy_clk_round_rate(struct clk_hw *hw,
>  			       unsigned long rate, unsigned long *parent_rate)
>  {
> +	u32 int_div_clk;
>  	int i;
> +	u16 m;
> +	u8 p, s;
> +
> +	/* If the clock is out of range return error instead of searching */
> +	if (rate > 297000000 || rate < 22250000)
> +		return -EINVAL;
>  
> +	/* Check the look-up table */
>  	for (i = ARRAY_SIZE(phy_pll_cfg) - 1; i >= 0; i--)
>  		if (phy_pll_cfg[i].pixclk <= rate)
> -			return phy_pll_cfg[i].pixclk;
> +			break;
> +	/* If the rate is an exact match, return it now */
> +	if (rate == phy_pll_cfg[i].pixclk)
> +		return phy_pll_cfg[i].pixclk;
> +
> +	/*
> +	 * The math on the lookup table shows the PMS math yields a
> +	 * frequency 5 x pixclk.
> +	 * When we check the integer divider against the desired rate,
> +	 * multiply the rate x 5 and then divide the outcome by 5.
> +	 */
> +	int_div_clk = fsl_samsung_hdmi_phy_find_pms(rate * 5, &p, &m, &s) / 5;
>  
> -	return -EINVAL;
> +	/* If the rate is an exact match, return it now */
> +	if (int_div_clk == rate)
> +		return int_div_clk;
> +
> +	/* Fall back to the closest value in the LUT */
> +	return phy_pll_cfg[i].pixclk;
>  }
>  
>  static int phy_clk_set_rate(struct clk_hw *hw,
>  			    unsigned long rate, unsigned long parent_rate)
>  {
>  	struct fsl_samsung_hdmi_phy *phy = to_fsl_samsung_hdmi_phy(hw);
> +	u32 int_div_clk;
>  	int i;
> -
> -	for (i = ARRAY_SIZE(phy_pll_cfg) - 1; i >= 0; i--)
> -		if (phy_pll_cfg[i].pixclk <= rate)
> -			break;
> -
> -	if (i < 0)
> -		return -EINVAL;
> -
> -	phy->cur_cfg = &phy_pll_cfg[i];
> +	u16 m;
> +	u8 p, s;
> +
> +	/* If the integer divider works, just use it */
> +	int_div_clk = fsl_samsung_hdmi_phy_find_pms(rate * 5, &p, &m, &s) / 5;
> +	if (int_div_clk == rate) {
> +		dev_dbg(phy->dev, "fsl_samsung_hdmi_phy: using integer divider\n");
> +		calculated_phy_pll_cfg.pixclk = int_div_clk;
> +		calculated_phy_pll_cfg.pll_div_regs[0] = FIELD_PREP(REG01_PMS_P_MASK, p);
> +		calculated_phy_pll_cfg.pll_div_regs[1] = m;
> +		calculated_phy_pll_cfg.pll_div_regs[2] = FIELD_PREP(REG03_PMS_S_MASK, s-1);
> +		/* pll_div_regs 3-6 are fixed and pre-defined already */
> +		phy->cur_cfg  = &calculated_phy_pll_cfg;
> +	} else {
> +		/* Otherwise, search the LUT */
> +		dev_dbg(phy->dev, "fsl_samsung_hdmi_phy: using fractional divider\n");> +		for (i = ARRAY_SIZE(phy_pll_cfg) - 1; i >= 0; i--)
> +			if (phy_pll_cfg[i].pixclk <= rate)
> +				break;
> +
> +		if (i < 0)
> +			return -EINVAL;
> +
> +		phy->cur_cfg = &phy_pll_cfg[i];
> +	}
>  
>  	return fsl_samsung_hdmi_phy_configure(phy, phy->cur_cfg);
>  }


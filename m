Return-Path: <linux-kernel+bounces-180633-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FC638C7107
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 06:48:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09321283624
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 04:48:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC91F14294;
	Thu, 16 May 2024 04:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="ECkfk4ni"
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 952FC10A0E;
	Thu, 16 May 2024 04:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.148.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715834916; cv=fail; b=kbDJiUSXvdf7WYYBK/CJqZ7VWZqGhDX2pEtid/C5v745BrUKmgwa1Ya5zV3e3qpqdgVabz/PZ7uPr7i5+biTVI7c6b8Tj0e0beLXqeQOzPZ3Q8hjL3qGnsRmpxWzGt7kdpgJWRD2hWm02E6kVRXuVBpc2a2+x1kARX+D0sHSdFs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715834916; c=relaxed/simple;
	bh=Wg4re4q98SUoc6kTvu6K9GyIn2BFosHkFNIZjetI5FA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=BMdp/cJYoLGd+y5iNfZ5f+fXGe4uoD+S9oFEgf+wUJO/X18RyckDB3K7gzAwSUOj+ZH3LtvQPMG9ku8vJ+bxJnLu7k6QegiMZIIw4FNZMuJ8TYTJB5H+UkM/Ui90iEAi5EWBnjrPWvu7Byp3TO6Ej2eYG9JdhEBe2pOScxrLFEA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=ECkfk4ni; arc=fail smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44G40An1017299;
	Wed, 15 May 2024 21:47:53 -0700
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3y5aqxr33m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 May 2024 21:47:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WQAOWQ5WLwZiLZUmh31RIjc+9H1u+rUdHbA7HpFl/UU2FJeD5glJUQ5Vsc+G4upYJBDwb3I2bpZiGQUE4deXgQ9IO/ubJG0wYQjIY8LZHpzkh4Z5qL4oTIcRpYx1lk5nUhj7AvFvx4JhLM6CkOjXQ5xailU56Zc+9phGNrf894Fsi+N+iiLHo5TX2nGEULaukI+dGDSuOy077Eoii44ujJFqM580ganNQEypVBSWEYwEB4vmrLnbwdKHf1+hcInjjVqi0vOA7DPH62/BfK9uD08C3p3qXhOY07K2SL0EEpCokr0BJIGw3ouVrao2dfSS7kHDoFXWcs02FsrJRbIDfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xC+lu2TrLJuaATL9R2HqUcGe2Bfqnzqpkg3frKMGZcA=;
 b=hB3s0Ll+Os2t18Qj1Xa/0FB6ZeKzLqiOOoh+QTS1xIbadLe9NyEkbXzCqBQ7qlrU7a33FtKZW3M6HKHN91TKejJpkB4vM2eLlgPe+X/bcdoLhIjLeOXeBTmELCvroDe4Qg1R7CYYSiiNS/sckqC8WP4ZjNYv8Nsg81+FG9XIt+wKlgvgeJK16YOyCTSVQWtReUVu0/DuWZM0K6imHVmOOmx1urSAbLJwaN2FbOO3PzcIF29pby5XOerXAGcr+CviQnx+URn8n90ztQ/U5imui+nd8hcnCGZzj78Ys6QakMeA0E/ZQLToI0zOlS1LcMVmvtIStLhUkS/2zfYYQjwnsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xC+lu2TrLJuaATL9R2HqUcGe2Bfqnzqpkg3frKMGZcA=;
 b=ECkfk4nigjHqN56EDuM644Enprg3t7U+/Wtah8pxM774XU8QziN+olxE55YYPAQfaNHAPOWadjOdUSnDdhHedOuh7HhazVKBcXNKqqK3b1oeJDmDo29/0IrtXzhZvZuKjkZ1WVyTafi7sBBWlnRPUdAMycaHVCnBj3RaPnH+ZU4=
Received: from MW4PR18MB5084.namprd18.prod.outlook.com (2603:10b6:303:1a7::8)
 by MW3PR18MB3513.namprd18.prod.outlook.com (2603:10b6:303:53::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.27; Thu, 16 May
 2024 04:47:49 +0000
Received: from MW4PR18MB5084.namprd18.prod.outlook.com
 ([fe80::1fe2:3c84:eebf:a905]) by MW4PR18MB5084.namprd18.prod.outlook.com
 ([fe80::1fe2:3c84:eebf:a905%5]) with mapi id 15.20.7587.028; Thu, 16 May 2024
 04:47:49 +0000
Message-ID: <dc0aa5ed-fc57-4d4b-8b71-45132524e4c1@marvell.com>
Date: Thu, 16 May 2024 10:17:39 +0530
User-Agent: Mozilla Thunderbird
Subject: [PATCH 4/4] firmware: imx: add driver for NXP EdgeLock Enclave
To: Pankaj Gupta <pankaj.gupta@nxp.com>, Jonathan Corbet <corbet@lwn.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, imx@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org
References: <20240510-imx-se-if-v1-0-27c5a674916d@nxp.com>
 <20240510-imx-se-if-v1-4-27c5a674916d@nxp.com>
Content-Language: en-US
From: Amit Singh Tomar <amitsinght@marvell.com>
In-Reply-To: <20240510-imx-se-if-v1-4-27c5a674916d@nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0127.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:bf::17) To MW4PR18MB5084.namprd18.prod.outlook.com
 (2603:10b6:303:1a7::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR18MB5084:EE_|MW3PR18MB3513:EE_
X-MS-Office365-Filtering-Correlation-Id: 06469653-ff80-4907-3999-08dc7563564f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|7416005|366007;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?TUF5TWQwZ05lODQrUlhrV1hvNlFZemVtdjhCY2hJaWxVajVNWHJPZFNaL3lo?=
 =?utf-8?B?S3Bqd1dmWW1jZmI3RGxHdWxHaWxlVHFGbGUyNkVOdnh4WHM3RnFPWUEzZmE4?=
 =?utf-8?B?L3d0SjNVY3MwM0xnTjNRVDlCMkE0Z0JpaStENWY1Qkt6ek9TN0dPVXlVY3hQ?=
 =?utf-8?B?Tys2MElRTVZCQkhOZVNrOTVKQWw1VEwreTQ2Y1lhVjg2VDQvazR4WlkxdHVC?=
 =?utf-8?B?Q0xyQlczTUFjejhSd1RyZktkeWJXRWpXM0NSUFpML2p1SjNLSEMwdktWaExx?=
 =?utf-8?B?WW9uYXZrUFAwOURBaGlBblNhb3paQlBTM21menNlekltMWFQSlI0eVNaT2Vy?=
 =?utf-8?B?ZndzT3M3V3ZTV0RZNmZOUjhGa2pTem94aENDSVUvY0RkcENsV1ZvWU1aNGlo?=
 =?utf-8?B?NXlCazVSbGJRVmlPUG1IS2FrUDhlYlA2SU9ORk5hYUsya2Zob1pORDQzMzlZ?=
 =?utf-8?B?Q2wybEVDaW9ZM2k0NmR2eWhyUnRLVUJwN1RmQzdISUlEMzVFOHB0SXFlb3V6?=
 =?utf-8?B?bkYyZG5XTThUbmRoSE5CQkpEOEh4UFZ1ME5jQnlxVU9MUHZxbTRUZ2RhU1Nw?=
 =?utf-8?B?RWFtZTFWNjdzU0pVVnoxNUxFMldRSGh1Zk1NSzd3ek5ITlJkQlhnZzV3UXhX?=
 =?utf-8?B?bW9pbWo5Zi9rNWl5TXVlS1hqQnBhaFVyVUNLOEIrWlVQYThzZ29lR3BGNld2?=
 =?utf-8?B?c1JKSzhZS0d5MlR6UGlPZStUZHd5R2NTSitLWFhaSE1SNmVkaW5IRUltcWov?=
 =?utf-8?B?YnNPSi9COFJUd3ZtZ25XMFhMT2h0RTloWjFOdUU4eGJKUTl6Yk5aZGQrSG5J?=
 =?utf-8?B?cnVOUUhaSEhpUGN2VmFOM2cxUnFzZm02VmpkYzd3bm1KbXJtbzNhc0FuWlJr?=
 =?utf-8?B?ZjBMcGZkcFdpMHY5dHVrbyswUWxHZmRnaEl6M1gvNllsUGNnUElwVTBON29B?=
 =?utf-8?B?M0Nid29kYll3R2NXdmxaRzZiM01pSzViRkE0TW5meFJibUpackdJdG1LcG5v?=
 =?utf-8?B?RFBtZjFRcFltR2lZYzkzL01iV2hXRU1MVk0xOCtCWklzM2Rackc1ZXpySklt?=
 =?utf-8?B?TWkyOUVMeE4rc0V1cTVvdXNUbkY0b2Vmek1zQk1FR3RhQ1hucnJObmMzVVZj?=
 =?utf-8?B?cjdTemtYZVhSL2ozMVJ0QWxzSUdzazhMclBYcnZVeTJvZ0dWREhBcnlEUGhx?=
 =?utf-8?B?ZTdObkYvS050dldRUmdsU01SNlhMSkMwRGwxRm8xeTZ4ZWhYZTJjWDM1K3FI?=
 =?utf-8?B?QXA1aG8zZk5rLzJtYjN4bXcwa2NYK0d4aElQbDU5eDRxQnh0QW1sVTlYZWQv?=
 =?utf-8?B?RnBCcG5Bb2tZcE8wK3pjMUpCbGJqSyszRmM4Q3gxeUZCRmNaVU9tQmdsSnhG?=
 =?utf-8?B?MUhYeFp6cWdNdDJ3SlFBR3h3dWNUeXJjN1hrazJmcmRzaE8zVmdpT1FqcUhR?=
 =?utf-8?B?dWI1dDRYOGlvTTlvSXZIU2lMK21MMnM3STZuR1dFblRybXpPdXE5U1U3ZHc3?=
 =?utf-8?B?WVV3VStvOVhrV29EWkRoYjRIK09BbHJwVkRIT29qTDRaYjJEZkRCVUhUZndj?=
 =?utf-8?B?aGgrWUNidHJuVUEyQSsvTitvMEJxejJHR01ZaTZhRFh6YytOTmhJRnZORWNC?=
 =?utf-8?Q?oNW0NZ4u8LhPIMRkNq1RZn1dVtacy2Ffqd1u47O9ClZI=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR18MB5084.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(7416005)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?R2hybHQxdlI4QXp4N1NJM093NDRJT3JFYjBqTEFFTXF5ZVJCamQ3L3A4ZDBq?=
 =?utf-8?B?V2cwQzBVRGNwcWZiRUg0ekg2RXo0N3RlQU1IUDFSR3NqVFpFV1Jjb0Nvc0NV?=
 =?utf-8?B?YjgraUJ4SU9ycDArQTRWTCtha2w4anFSR1ZRL0pIbmh6VUZGcnM4UEt3V21R?=
 =?utf-8?B?VHZuYTBFKzJFQzgvdWp1ejZRRXFUMmlIOHNRWnpjOEdLdUJwN2lWdjZhUUZS?=
 =?utf-8?B?T0t4RmtpRXVIMTB0cmJtYTBUazFULzNENTk3cm9VM3IrdVBzUXFEMndiRzU5?=
 =?utf-8?B?SUoyaGlWT3l3UE02L3hXYkpabkxLbkZqdXFwdWxIbVNxRFdHUzRwR0YzYksz?=
 =?utf-8?B?Z3lXanVTa3FhSWNlVWFVNVgxQXZFZUgyQThkcXlDaVFNbGIweWtiNDFjMnFk?=
 =?utf-8?B?VmxUbnF4UDhFRjBUMUpBVEZnaHA0eTBPaWdYN2pmL2NnUGNFa0xxY3RTSnpv?=
 =?utf-8?B?c3JLdGJoWUlId21kYUJsZUZZNk9QK3RGUkEvdXFxS3doL25DMlNGVzZFT1Vo?=
 =?utf-8?B?U3lGVE12MGF3NldGZDlyWndWVGoyS0VodDRYSTd1d3NpTDNhRy9Ca212T1pK?=
 =?utf-8?B?Rk1TNHlndXBrOCt1U1JZUHdtYUVVVFlKM1E1M1Q2WFNQNjBOZlZrOEFoREJR?=
 =?utf-8?B?RWtEVE45WHNYMHBnTWt2Z0U2SzM1dlFYSUhqVWw2U3Y4OTNnSy93MjR6MHov?=
 =?utf-8?B?QzNtWkxJaGVaZU0zakxxQWhxeXVsOVpndHZyZUJ4ZEhyMTAzOEhYWXFySFVY?=
 =?utf-8?B?c1hqUUtSY1AxQ2wxY2FzR0YrSk1lOFhjTGVHTlFMaFNiZFRaWHBQYkN2aU1w?=
 =?utf-8?B?aGMybmY2dklUazJ1Z3doQTloTERab2UzMlZoN0VrVFdvd2pndG9hbUI5STVN?=
 =?utf-8?B?VnozZDhWeEtudkE1YUthYzZMVmFneU42WEtlK0M0Y1FNcVlkOHB1STdVOE40?=
 =?utf-8?B?OWdTd0drcUI4MXVNV1RuMGx4Q2pFbEIvZnp6c3JCZ25hS0MyMlFvNEU0L0JU?=
 =?utf-8?B?QUpzMnBqR1BVMWlJRGgrbXVBVG9TM0JwMFhqbG9XNXRLUk1VMTRUL2lacjVk?=
 =?utf-8?B?dzZ1ZGc1c3R6YUNBVlExY3ljRlpjRG5mMjJ1WnBPUkp2UFFQTzJsOUZscGhK?=
 =?utf-8?B?RnppclU1aGJldUlkRlV0eFBKa3BhUXR6SW9GaElpbUNEcW5uQUJMazI3QnE5?=
 =?utf-8?B?UlNRYUhBdmd1Y2xNMzFSSFFGSjQwcVpEa3ZVc0lQR3oyS0diTzd1VHRod042?=
 =?utf-8?B?RzgvZWxMeXFrOG5mNzBnSTRJelJNRXlFNGNlSkJBTEZ1MVJ1NnRaQytraUlj?=
 =?utf-8?B?S2RvS3lnYlVGc3Q4Vmc1aVBSbDcxUHIwRWJBNkUya0VSRGxFNnRGL1hRb1FD?=
 =?utf-8?B?N0JEQi9LUm42a05jc2t5ajFpM1hLVi9xQzNRTGhTYzVnT3ZzM0FkcjMxSkZk?=
 =?utf-8?B?UEl0S25EWUJseW9NWFdOUVFtZ3dUQmpLYlFCbXVWbzl6Sm5YRVQ3akNUOWlz?=
 =?utf-8?B?d3BPYXZaVW5hRjRRS1YwSnNFWVR1RThWZGZzNTlMd24xRDZIWXduZ1hGeEtp?=
 =?utf-8?B?ODZTaWpNMytQRlBTbkhwelJtalVFODJYY29ZN3hTL3BFZ1dLUjcvMTVDZVAr?=
 =?utf-8?B?NStSQW1GRTQrUVBseEthVXNZTnRVL3dvSHd4SjZJdmZQN01GbkxvTFh5RnpI?=
 =?utf-8?B?QlY3akR2RlB0WldlT1RXczNwNUJEVlE1a3AyTyt3STFYWGluQXdNNjRDdDZ5?=
 =?utf-8?B?c0RjTHcvWUIzTmwvYmZpNUIxbnV1S3c4Qm9KRUt2Q0VLSVE5S0o5TlFJdVkw?=
 =?utf-8?B?S2d0Y0YwY1RaK2cwc3lsbmxNRmt2d1NVbE5FbzgrcHExVTZKa1NiVVl5N01s?=
 =?utf-8?B?ZTJOSEtxKzAvQjlGT3lBbWFDcnRaVURRTlhuOWJWbVhJOGcwd25LVFJWNDda?=
 =?utf-8?B?WUJwWU1SbXNiYzFGNkFRYkFHQ1ZIaDF0SHFtVUlUbzZFWFJvRFBRWlpWd2sw?=
 =?utf-8?B?YmlldHFyVFNHeTBEV3lrRUtJLzVQT3NTaWNYUkJaUkg1SzEwbE5EcjJCQjFR?=
 =?utf-8?B?REZETjMwZ3ZPNGY0TDB2eHIrSTNURCtuMW5SNHdDdVBJanhnbFdhcUpNRjdZ?=
 =?utf-8?Q?H4y87Kppn7kURJZn9DC9Z0DuQ?=
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06469653-ff80-4907-3999-08dc7563564f
X-MS-Exchange-CrossTenant-AuthSource: MW4PR18MB5084.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2024 04:47:49.5255
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8kS5X27p5sOWWhnrr7gRPUhUTXAtycPu5SbvUQ8uswdY1SfnpDpiEBHGDkiSkasB+nBgX7HEY7Ok1J8v4Z1IQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR18MB3513
X-Proofpoint-GUID: dPxE103jJAKP8cXSKapT2kxO8qPDfB1p
X-Proofpoint-ORIG-GUID: dPxE103jJAKP8cXSKapT2kxO8qPDfB1p
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-16_01,2024-05-15_01,2023-05-22_02

> ----------------------------------------------------------------------
> NXP hardware IP(s) for secure-enclaves like Edgelock Enclave(ELE),
> are embedded in the SoC to support the features like HSM, SHE & V2X,
> using message based communication interface.
> 
> The secure enclave FW communicates on a dedicated messaging unit(MU)
> based interface(s) with application core, where kernel is running.
> It exists on specific i.MX processors. e.g. i.MX8ULP, i.MX93.
> 
> This patch adds the driver for communication interface to secure-enclave,
> for exchanging messages with NXP secure enclave HW IP(s) like EdgeLock Enclave,
> both from:
> - User-Space Applications via character driver.
> - Kernel-space, used by kernel management layers like DM-Crypt.
> 
> ABI documentation for the NXP secure-enclave driver.
> 
> User-space library using this driver:
> - i.MX Secure Enclave library:
>    -- URL: https://urldefense.proofpoint.com/v2/url?u=https-3A__github.com_nxp-2Dimx_imx-2Dsecure-2Denclave.git&d=DwICAg&c=nKjWec2b6R0mOyPaz7xtfQ&r=V_GK7jRuCHDErm6txmgDK1-MbUihtnSQ3gPgB-A-JKU&m=lRJFNDYT5J3dZTYPCtbQrN6ho5BaZc62rCnOKShFGK0aosnXA0JKGr_OrCPlpaat&s=GFFpXM8z8-pliprvP1Xs1NsiJ8yEvE9xFQuUIGLYoe8&e= ,
> - i.MX Secure Middle-Ware:
>    -- URL: https://urldefense.proofpoint.com/v2/url?u=https-3A__github.com_nxp-2Dimx_imx-2Dsmw.git&d=DwICAg&c=nKjWec2b6R0mOyPaz7xtfQ&r=V_GK7jRuCHDErm6txmgDK1-MbUihtnSQ3gPgB-A-JKU&m=lRJFNDYT5J3dZTYPCtbQrN6ho5BaZc62rCnOKShFGK0aosnXA0JKGr_OrCPlpaat&s=aCsO_lLG71KPvjVgXlx9Ly0Ed05XnSUJ4z-xxqxSze8&e=
> 
> Signed-off-by: Pankaj Gupta <pankaj.gupta@nxp.com>
> ---
>   Documentation/ABI/testing/se-cdev   |   42 ++
>   drivers/firmware/imx/Kconfig        |   12 +
>   drivers/firmware/imx/Makefile       |    2 +
>   drivers/firmware/imx/ele_base_msg.c |  287 ++++++++
>   drivers/firmware/imx/ele_base_msg.h |   70 ++
>   drivers/firmware/imx/ele_common.c   |  341 +++++++++
>   drivers/firmware/imx/ele_common.h   |   43 ++
>   drivers/firmware/imx/se_ctrl.c      | 1339 +++++++++++++++++++++++++++++++++++
>   drivers/firmware/imx/se_ctrl.h      |  151 ++++
>   include/linux/firmware/imx/se_api.h |   14 +
>   include/uapi/linux/se_ioctl.h       |   88 +++
>   11 files changed, 2389 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/se-cdev b/Documentation/ABI/testing/se-cdev
> new file mode 100644
> index 000000000000..699525af6b86
> --- /dev/null
> +++ b/Documentation/ABI/testing/se-cdev
> @@ -0,0 +1,42 @@
> +What:		/dev/<se>_mu[0-9]+_ch[0-9]+
> +Date:		May 2024
> +KernelVersion:	6.8
> +Contact:	linux-imx@nxp.com, pankaj.gupta@nxp.com
> +Description:
> +		NXP offers multiple hardware IP(s) for  secure-enclaves like EdgeLock-
> +		Enclave(ELE), SECO. The character device file-descriptors
> +		/dev/<se>_mu*_ch* are the interface between user-space NXP's secure-
> +		enclave shared-library and the kernel driver.
> +
> +		The ioctl(2)-based ABI is defined and documented in
> +		[include]<linux/firmware/imx/ele_mu_ioctl.h>
> +		 ioctl(s) are used primarily for:
> +			- shared memory management
> +			- allocation of I/O buffers
> +			- get mu info
> +			- setting a dev-ctx as receiver that is slave to fw
> +			- get SoC info
> +
> +		The following file operations are supported:
> +
> +		open(2)
> +		  Currently the only useful flags are O_RDWR.
> +
> +		read(2)
> +		  Every read() from the opened character device context is waiting on
> +		  wakeup_intruptible, that gets set by the registered mailbox callback
> +		  function; indicating a message received from the firmware on message-
> +		  unit.
> +
> +		write(2)
> +		  Every write() to the opened character device context needs to acquire
> +		  mailbox_lock, before sending message on to the message unit.
> +
> +		close(2)
> +		  Stops and free up the I/O contexts that was associated
> +		  with the file descriptor.
> +
> +Users:		https://urldefense.proofpoint.com/v2/url?u=https-3A__github.com_nxp-2Dimx_imx-2Dsecure-2Denclave.git&d=DwICAg&c=nKjWec2b6R0mOyPaz7xtfQ&r=V_GK7jRuCHDErm6txmgDK1-MbUihtnSQ3gPgB-A-JKU&m=lRJFNDYT5J3dZTYPCtbQrN6ho5BaZc62rCnOKShFGK0aosnXA0JKGr_OrCPlpaat&s=GFFpXM8z8-pliprvP1Xs1NsiJ8yEvE9xFQuUIGLYoe8&e= ,
> +		https://urldefense.proofpoint.com/v2/url?u=https-3A__github.com_nxp-2Dimx_imx-2Dsmw.git&d=DwICAg&c=nKjWec2b6R0mOyPaz7xtfQ&r=V_GK7jRuCHDErm6txmgDK1-MbUihtnSQ3gPgB-A-JKU&m=lRJFNDYT5J3dZTYPCtbQrN6ho5BaZc62rCnOKShFGK0aosnXA0JKGr_OrCPlpaat&s=aCsO_lLG71KPvjVgXlx9Ly0Ed05XnSUJ4z-xxqxSze8&e=
> +		crypto/skcipher,
> +		drivers/nvmem/imx-ocotp-ele.c
> diff --git a/drivers/firmware/imx/Kconfig b/drivers/firmware/imx/Kconfig
> index 183613f82a11..56bdca9bd917 100644
> --- a/drivers/firmware/imx/Kconfig
> +++ b/drivers/firmware/imx/Kconfig
> @@ -22,3 +22,15 @@ config IMX_SCU
>   
>   	  This driver manages the IPC interface between host CPU and the
>   	  SCU firmware running on M4.
> +
> +config IMX_SEC_ENCLAVE
> +	tristate "i.MX Embedded Secure Enclave - EdgeLock Enclave Firmware driver."
> +	depends on IMX_MBOX && ARCH_MXC && ARM64
> +	default m if ARCH_MXC
> +
> +	help
> +	  It is possible to use APIs exposed by the iMX Secure Enclave HW IP called:
> +          - EdgeLock Enclave Firmware (for i.MX8ULP, i.MX93),
> +          like base, HSM, V2X & SHE using the SAB protocol via the shared Messaging
> +          Unit. This driver exposes these interfaces via a set of file descriptors
> +          allowing to configure shared memory, send and receive messages.
> diff --git a/drivers/firmware/imx/Makefile b/drivers/firmware/imx/Makefile
> index 8f9f04a513a8..aa9033e0e9e3 100644
> --- a/drivers/firmware/imx/Makefile
> +++ b/drivers/firmware/imx/Makefile
> @@ -1,3 +1,5 @@
>   # SPDX-License-Identifier: GPL-2.0
>   obj-$(CONFIG_IMX_DSP)		+= imx-dsp.o
>   obj-$(CONFIG_IMX_SCU)		+= imx-scu.o misc.o imx-scu-irq.o rm.o imx-scu-soc.o
> +sec_enclave-objs		= se_ctrl.o ele_common.o ele_base_msg.o
> +obj-${CONFIG_IMX_SEC_ENCLAVE}	+= sec_enclave.o
> diff --git a/drivers/firmware/imx/ele_base_msg.c b/drivers/firmware/imx/ele_base_msg.c
> new file mode 100644
> index 000000000000..0463f26d93c7
> --- /dev/null
> +++ b/drivers/firmware/imx/ele_base_msg.c
> @@ -0,0 +1,287 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright 2024 NXP
> + */
> +
> +#include <linux/types.h>
> +#include <linux/completion.h>
> +#include <linux/dma-mapping.h>
> +
> +#include "ele_base_msg.h"
> +#include "ele_common.h"
> +
> +int ele_get_info(struct device *dev, struct soc_info *s_info)
> +{
> +	struct se_if_priv *priv = dev_get_drvdata(dev);
> +	struct se_api_msg *tx_msg __free(kfree);
> +	struct se_api_msg *rx_msg __free(kfree);
> +	phys_addr_t get_info_addr;
> +	u32 *get_info_data;
> +	u32 status;
> +	int ret;
> +
> +	if (!priv || !s_info)
> +		goto exit;
> +
> +	memset(s_info, 0x0, sizeof(*s_info));
> +
> +	if (priv->mem_pool_name)
> +		get_info_data = get_phy_buf_mem_pool(dev,
> +						     priv->mem_pool_name,
> +						     &get_info_addr,
> +						     ELE_GET_INFO_BUFF_SZ);
> +	else
> +		get_info_data = dmam_alloc_coherent(dev,
> +						    ELE_GET_INFO_BUFF_SZ,
> +						    &get_info_addr,
> +						    GFP_KERNEL);
> +	if (!get_info_data) {
> +		ret = -ENOMEM;
> +		dev_err(dev,
> +			"%s: Failed to allocate get_info_addr.\n",
> +			__func__);
> +		goto exit;
> +	}
> +
> +	tx_msg = kzalloc(ELE_GET_INFO_REQ_MSG_SZ << 2, GFP_KERNEL);
> +	if (!tx_msg) {
> +		ret = -ENOMEM;
> +		return ret;
> +	}
> +
> +	rx_msg = kzalloc(ELE_GET_INFO_RSP_MSG_SZ << 2, GFP_KERNEL);
> +	if (!rx_msg) {
> +		ret = -ENOMEM;
> +		return ret;
> +	}
> +
> +	ret = plat_fill_cmd_msg_hdr(priv,
> +				    (struct se_msg_hdr *)&tx_msg->header,
> +				    ELE_GET_INFO_REQ,
> +				    ELE_GET_INFO_REQ_MSG_SZ,
> +				    true);
> +	if (ret)
> +		goto exit;
> +
> +	tx_msg->data[0] = upper_32_bits(get_info_addr);
> +	tx_msg->data[1] = lower_32_bits(get_info_addr);
> +	tx_msg->data[2] = ELE_GET_INFO_READ_SZ;
> +	priv->rx_msg = rx_msg;
> +	ret = imx_ele_msg_send_rcv(priv, tx_msg);
> +	if (ret < 0)
> +		goto exit;
> +
> +	ret  = validate_rsp_hdr(priv,
> +				priv->rx_msg->header,
> +				ELE_GET_INFO_REQ,
> +				ELE_GET_INFO_RSP_MSG_SZ,
> +				true);
> +	if (ret)
> +		goto exit;
> +
> +	status = RES_STATUS(priv->rx_msg->data[0]);
> +	if (status != priv->success_tag) {
> +		dev_err(dev, "Command Id[%d], Response Failure = 0x%x",
> +			ELE_GET_INFO_REQ, status);
> +		ret = -1;
> +	}
> +
> +	s_info->imem_state = (get_info_data[ELE_IMEM_STATE_WORD]
> +				& ELE_IMEM_STATE_MASK) >> 16;
> +	s_info->major_ver = (get_info_data[GET_INFO_SOC_INFO_WORD_OFFSET]
> +				& SOC_VER_MASK) >> 24;
> +	s_info->minor_ver = ((get_info_data[GET_INFO_SOC_INFO_WORD_OFFSET]
> +				& SOC_VER_MASK) >> 16) & 0xFF;
> +	s_info->soc_rev = (get_info_data[GET_INFO_SOC_INFO_WORD_OFFSET]
> +				& SOC_VER_MASK) >> 16;
> +	s_info->soc_id = get_info_data[GET_INFO_SOC_INFO_WORD_OFFSET]
> +				& SOC_ID_MASK;
> +	s_info->serial_num
> +		= (u64)get_info_data[GET_INFO_SL_NUM_MSB_WORD_OFF] << 32
> +			| get_info_data[GET_INFO_SL_NUM_LSB_WORD_OFF];
> +exit:
> +	if (get_info_addr) {
> +		if (priv->mem_pool_name)
> +			free_phybuf_mem_pool(dev, priv->mem_pool_name,
> +					     get_info_data, ELE_GET_INFO_BUFF_SZ);
> +		else
> +			dmam_free_coherent(dev,
> +					   ELE_GET_INFO_BUFF_SZ,
> +					   get_info_data,
> +					   get_info_addr);
> +	}
> +
> +	return ret;
> +}
> +
> +int ele_ping(struct device *dev)
> +{
> +	struct se_if_priv *priv = dev_get_drvdata(dev);
> +	struct se_api_msg *tx_msg __free(kfree);
> +	struct se_api_msg *rx_msg __free(kfree);
> +	u32 status;
> +	int ret;
> +
> +	tx_msg = kzalloc(ELE_PING_REQ_SZ << 2, GFP_KERNEL);
> +	if (!tx_msg) {
> +		ret = -ENOMEM;
> +		return ret;
> +	}
> +
> +	rx_msg = kzalloc(ELE_PING_RSP_SZ << 2, GFP_KERNEL);
> +	if (!rx_msg) {
> +		ret = -ENOMEM;
> +		return ret;
> +	}
> +
> +	ret = plat_fill_cmd_msg_hdr(priv,
> +				    (struct se_msg_hdr *)&tx_msg->header,
> +				    ELE_PING_REQ, ELE_PING_REQ_SZ,
> +				    true);
> +	if (ret) {
> +		dev_err(dev, "Error: plat_fill_cmd_msg_hdr failed.\n");
> +		goto exit;
> +	}
> +
> +	priv->rx_msg = rx_msg;
> +	ret = imx_ele_msg_send_rcv(priv, tx_msg);
> +	if (ret)
> +		goto exit;
> +
> +	ret  = validate_rsp_hdr(priv,
> +				priv->rx_msg->header,
> +				ELE_PING_REQ,
> +				ELE_PING_RSP_SZ,
> +				true);
> +	if (ret)
> +		goto exit;
> +
> +	status = RES_STATUS(priv->rx_msg->data[0]);
> +	if (status != priv->success_tag) {
> +		dev_err(dev, "Command Id[%d], Response Failure = 0x%x",
> +			ELE_PING_REQ, status);
> +		ret = -1;
> +	}
> +exit:
> +	return ret;
> +}
> +
> +int ele_service_swap(struct device *dev,
> +		     phys_addr_t addr,
> +		     u32 addr_size, u16 flag)
> +{
> +	struct se_if_priv *priv = dev_get_drvdata(dev);
> +	struct se_api_msg *tx_msg __free(kfree);
> +	struct se_api_msg *rx_msg __free(kfree);
> +	u32 status;
> +	int ret;
> +
> +	tx_msg = kzalloc(ELE_SERVICE_SWAP_REQ_MSG_SZ << 2, GFP_KERNEL);
> +	if (!tx_msg) {
> +		ret = -ENOMEM;
> +		return ret;
> +	}
> +
> +	rx_msg = kzalloc(ELE_SERVICE_SWAP_RSP_MSG_SZ << 2, GFP_KERNEL);
> +	if (!rx_msg) {
> +		ret = -ENOMEM;
> +		return ret;
> +	}
> +
> +	ret = plat_fill_cmd_msg_hdr(priv,
> +				    (struct se_msg_hdr *)&tx_msg->header,
> +				    ELE_SERVICE_SWAP_REQ,
> +				    ELE_SERVICE_SWAP_REQ_MSG_SZ,
> +				    true);
> +	if (ret)
> +		goto exit;
> +
> +	tx_msg->data[0] = flag;
> +	tx_msg->data[1] = addr_size;
> +	tx_msg->data[2] = ELE_NONE_VAL;
> +	tx_msg->data[3] = lower_32_bits(addr);
> +	tx_msg->data[4] = plat_add_msg_crc((uint32_t *)&tx_msg[0],
> +						 ELE_SERVICE_SWAP_REQ_MSG_SZ);
> +	priv->rx_msg = rx_msg;
> +	ret = imx_ele_msg_send_rcv(priv, tx_msg);
> +	if (ret < 0)
> +		goto exit;
> +
> +	ret  = validate_rsp_hdr(priv,
> +				priv->rx_msg->header,
> +				ELE_SERVICE_SWAP_REQ,
> +				ELE_SERVICE_SWAP_RSP_MSG_SZ,
> +				true);
> +	if (ret)
> +		goto exit;
> +
> +	status = RES_STATUS(priv->rx_msg->data[0]);
> +	if (status != priv->success_tag) {
> +		dev_err(dev, "Command Id[%d], Response Failure = 0x%x",
> +			ELE_SERVICE_SWAP_REQ, status);
> +		ret = -1;
> +	} else {
> +		if (flag == ELE_IMEM_EXPORT)
> +			ret = priv->rx_msg->data[1];
> +		else
> +			ret = 0;
> +	}
> +exit:
> +
> +	return ret;
> +}
> +
> +int ele_fw_authenticate(struct device *dev, phys_addr_t addr)
> +{
> +	struct se_if_priv *priv = dev_get_drvdata(dev);
> +	struct se_api_msg *tx_msg __free(kfree);
> +	struct se_api_msg *rx_msg __free(kfree);
> +	u32 status;
> +	int ret;
> +
> +	tx_msg = kzalloc(ELE_FW_AUTH_REQ_SZ << 2, GFP_KERNEL);
> +	if (!tx_msg) {
> +		ret = -ENOMEM;
> +		return ret;
> +	}
> +
> +	rx_msg = kzalloc(ELE_FW_AUTH_RSP_MSG_SZ << 2, GFP_KERNEL);
> +	if (!rx_msg) {
> +		ret = -ENOMEM;
> +		return ret;
> +	}
> +	ret = plat_fill_cmd_msg_hdr(priv,
> +				    (struct se_msg_hdr *)&tx_msg->header,
> +				    ELE_FW_AUTH_REQ,
> +				    ELE_FW_AUTH_REQ_SZ,
> +				    true);
> +	if (ret)
> +		goto exit;
> +
> +	tx_msg->data[0] = addr;
> +	tx_msg->data[1] = 0x0;
> +	tx_msg->data[2] = addr;
> +
> +	priv->rx_msg = rx_msg;
> +	ret = imx_ele_msg_send_rcv(priv, tx_msg);
> +	if (ret < 0)
> +		goto exit;
> +
> +	ret  = validate_rsp_hdr(priv,
> +				priv->rx_msg->header,
> +				ELE_FW_AUTH_REQ,
> +				ELE_FW_AUTH_RSP_MSG_SZ,
> +				true);
> +	if (ret)
> +		goto exit;
> +
> +	status = RES_STATUS(priv->rx_msg->data[0]);
> +	if (status != priv->success_tag) {
> +		dev_err(dev, "Command Id[%d], Response Failure = 0x%x",
> +			ELE_FW_AUTH_REQ, status);
> +		ret = -1;
> +	}
> +exit:
> +
> +	return ret;
> +}
> diff --git a/drivers/firmware/imx/ele_base_msg.h b/drivers/firmware/imx/ele_base_msg.h
> new file mode 100644
> index 000000000000..3b3d2bf04a84
> --- /dev/null
> +++ b/drivers/firmware/imx/ele_base_msg.h
> @@ -0,0 +1,70 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +/*
> + * Copyright 2024 NXP
> + *
> + * Header file for the EdgeLock Enclave Base API(s).
> + */
> +
> +#ifndef ELE_BASE_MSG_H
> +#define ELE_BASE_MSG_H
> +
> +#include <linux/device.h>
> +#include <linux/types.h>
> +
> +#define WORD_SZ				4
> +#define ELE_NONE_VAL			0x0
> +
> +#define ELE_SUCCESS_IND			0xD6
> +
> +#define ELE_GET_INFO_REQ		0xDA
> +#define ELE_GET_INFO_REQ_MSG_SZ		0x10
> +#define ELE_GET_INFO_RSP_MSG_SZ		0x08
> +
> +#define ELE_GET_INFO_BUFF_SZ		0x100
> +#define ELE_GET_INFO_READ_SZ		0xA0
> +
> +#define DEFAULT_IMX_SOC_VER		0xA0
> +#define SOC_VER_MASK			0xFFFF0000
> +#define SOC_ID_MASK			0x0000FFFF
> +struct soc_info {
> +	u32 imem_state;
> +	u8 major_ver;
> +	u8 minor_ver;
> +	u16 soc_id;
> +	u16 soc_rev;
> +	u64 serial_num;
> +};
> +
> +#define GET_INFO_SOC_INFO_WORD_OFFSET	1
> +#define GET_INFO_UUID_WORD_OFFSET	3
> +#define GET_INFO_SL_NUM_MSB_WORD_OFF \
> +	(GET_INFO_UUID_WORD_OFFSET + 3)
> +#define GET_INFO_SL_NUM_LSB_WORD_OFF \
> +	(GET_INFO_UUID_WORD_OFFSET + 0)
> +
> +#define ELE_PING_REQ			0x01
> +#define ELE_PING_REQ_SZ			0x04
> +#define ELE_PING_RSP_SZ			0x08
> +
> +#define ELE_SERVICE_SWAP_REQ		0xDF
> +#define ELE_SERVICE_SWAP_REQ_MSG_SZ	0x18
> +#define ELE_SERVICE_SWAP_RSP_MSG_SZ	0x0C
> +#define ELE_IMEM_SIZE			0x10000
> +#define ELE_IMEM_STATE_OK		0xCA
> +#define ELE_IMEM_STATE_BAD		0xFE
> +#define ELE_IMEM_STATE_WORD		0x27
> +#define ELE_IMEM_STATE_MASK		0x00ff0000
> +#define ELE_IMEM_EXPORT			0x1
> +#define ELE_IMEM_IMPORT			0x2
> +
> +#define ELE_FW_AUTH_REQ			0x02
> +#define ELE_FW_AUTH_REQ_SZ		0x10
> +#define ELE_FW_AUTH_RSP_MSG_SZ		0x08
> +
> +int ele_get_info(struct device *dev, struct soc_info *s_info);
> +int ele_ping(struct device *dev);
> +int ele_service_swap(struct device *dev,
> +		     phys_addr_t addr,
> +		     u32 addr_size, u16 flag);
> +int ele_fw_authenticate(struct device *dev, phys_addr_t addr);
> +#endif
> diff --git a/drivers/firmware/imx/ele_common.c b/drivers/firmware/imx/ele_common.c
> new file mode 100644
> index 000000000000..dcf7f9034653
> --- /dev/null
> +++ b/drivers/firmware/imx/ele_common.c
> @@ -0,0 +1,341 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright 2024 NXP
> + */
> +
> +#include "ele_base_msg.h"
> +#include "ele_common.h"
> +
> +u32 plat_add_msg_crc(u32 *msg, u32 msg_len)
> +{
> +	u32 nb_words = msg_len / (u32)sizeof(u32);
> +	u32 crc = 0;
> +	u32 i;
> +
> +	for (i = 0; i < nb_words - 1; i++)
> +		crc ^= *(msg + i);
> +
> +	return crc;
> +}
> +
> +int imx_ele_msg_rcv(struct se_if_priv *priv)
> +{
> +	u32 wait;
> +	int err;
> +
> +	wait = msecs_to_jiffies(1000);
> +	if (!wait_for_completion_timeout(&priv->done, wait)) {
> +		dev_err(priv->dev,
> +				"Error: wait_for_completion timed out.\n");
> +		err = -ETIMEDOUT;
> +	}
> +
> +	mutex_unlock(&priv->se_if_cmd_lock);
> +	priv->no_dev_ctx_used = false;
> +
> +	return err;
> +}
> +
> +int imx_ele_msg_send(struct se_if_priv *priv, void *mssg)
> +{
> +	bool is_cmd_lock_tobe_taken = false;
> +	int err;
> +
> +	if (!priv->waiting_rsp_dev || priv->no_dev_ctx_used) {
> +		is_cmd_lock_tobe_taken = true;
> +		mutex_lock(&priv->se_if_cmd_lock);
> +	}
> +	scoped_guard(mutex, &priv->se_if_lock);
> +
> +	err = mbox_send_message(priv->tx_chan, mssg);
> +	if (err < 0) {
> +		dev_err(priv->dev, "Error: mbox_send_message failure.\n");
> +		if (is_cmd_lock_tobe_taken)
> +			mutex_unlock(&priv->se_if_cmd_lock);
> +		return err;
> +	}
> +	err = 0;

It looks odd, you can simply return 0 in the following statement.

> +
> +	return err;
> +}
> +
> +int imx_ele_msg_send_rcv(struct se_if_priv *priv, void *mssg)
> +{
> +	int err;
> +
> +	priv->no_dev_ctx_used = true;
> +	err = imx_ele_msg_send(priv, mssg);
> +	if (err)
> +		goto exit;
> +
> +	err = imx_ele_msg_rcv(priv);
> +
> +exit:
> +	return err;
> +}
> +
> +int imx_ele_miscdev_msg_rcv(struct se_if_device_ctx *dev_ctx)
> +{
> +	struct se_msg_hdr header = {0};
> +	int err;
> +
> +	err = wait_event_interruptible(dev_ctx->wq, dev_ctx->pending_hdr != 0);
> +	if (err)
> +		dev_err(dev_ctx->dev,
> +			"%s: Err[0x%x]:Interrupted by signal.\n",
> +			dev_ctx->miscdev.name, err);
> +
> +	header = *((struct se_msg_hdr *) (&dev_ctx->temp_resp[0]));
> +
> +	if (header.tag == dev_ctx->priv->rsp_tag)
> +		mutex_unlock(&dev_ctx->priv->se_if_cmd_lock);
> +
> +	return err;
> +}
> +
> +int imx_ele_miscdev_msg_send(struct se_if_device_ctx *dev_ctx,
> +			     void *tx_msg, int tx_msg_sz)
> +{
> +	struct se_if_priv *priv = dev_ctx->priv;
> +	struct se_msg_hdr header = {0};
> +	int err;
> +
> +	header = *((struct se_msg_hdr *) tx_msg);
> +
> +	/*
> +	 * Check that the size passed as argument matches the size
> +	 * carried in the message.
> +	 */
> +	err = header.size << 2;
> +
> +	if (err != tx_msg_sz) {
> +		err = -EINVAL;
> +		dev_err(priv->dev,
> +			"%s: User buffer too small\n",
> +				dev_ctx->miscdev.name);
> +		goto exit;
> +	}
> +	/* Check the message is valid according to tags */
> +	if (header.tag == priv->cmd_tag)
> +		priv->waiting_rsp_dev = dev_ctx;
> +	else if (header.tag == priv->rsp_tag) {
> +		/* Check the device context can send the command */
> +		if (dev_ctx != priv->cmd_receiver_dev) {
> +			dev_err(priv->dev,
> +				"%s: Channel not configured to send resp to FW.",
> +				dev_ctx->miscdev.name);
> +			err = -EPERM;
> +			goto exit;
> +		}
> +	} else {
> +		dev_err(priv->dev,
> +			"%s: The message does not have a valid TAG\n",
> +				dev_ctx->miscdev.name);
> +		err = -EINVAL;
> +		goto exit;
> +	}
> +	err = imx_ele_msg_send(priv, tx_msg);
> +exit:
> +	return err;
> +}
> +
> +/*
> + * Callback called by mailbox FW, when data is received.
> + */
> +void se_if_rx_callback(struct mbox_client *mbox_cl, void *msg)
> +{
> +	struct device *dev = mbox_cl->dev;
> +	struct se_if_device_ctx *dev_ctx;
> +	struct se_api_msg *rx_msg;
> +	bool is_response = false;
> +	struct se_if_priv *priv;
> +	struct se_msg_hdr header;
> +
> +	priv = dev_get_drvdata(dev);
> +	if (!priv) {
> +		dev_err(dev, "SE-MU Priv data is NULL;");
> +		return;
> +	}
> +
> +	/* The function can be called with NULL msg */
> +	if (!msg) {
> +		dev_err(dev, "Message is invalid\n");
> +		return;
> +	}
> +
> +	header.tag = ((u8 *)msg)[TAG_OFFSET];
> +	header.command = ((u8 *)msg)[CMD_OFFSET];
> +	header.size = ((u8 *)msg)[SZ_OFFSET];
> +	header.ver = ((u8 *)msg)[VER_OFFSET];
> +
> +	/* Incoming command: wake up the receiver if any. */
> +	if (header.tag == priv->cmd_tag) {
> +		dev_dbg(dev, "Selecting cmd receiver\n");
> +		dev_ctx = priv->cmd_receiver_dev;
> +	} else if (header.tag == priv->rsp_tag) {
> +		if (priv->waiting_rsp_dev) {
> +			dev_dbg(dev, "Selecting rsp waiter\n");
> +			dev_ctx = priv->waiting_rsp_dev;
> +			is_response = true;
> +		} else {
> +			/*
> +			 * Reading the EdgeLock Enclave response
> +			 * to the command, sent by other
> +			 * linux kernel services.
> +			 */
> +			spin_lock(&priv->lock);
> +			memcpy(&priv->rx_msg, msg, header.size << 2);
> +
> +			complete(&priv->done);
> +			spin_unlock(&priv->lock);
> +			return;
> +		}
> +	} else {
> +		dev_err(dev, "Failed to select a device for message: %.8x\n",
> +				*((u32 *) &header));
> +		return;
> +	}
> +	/* Init reception */
> +	rx_msg = kzalloc(header.size << 2, GFP_KERNEL);
> +	if (rx_msg)
> +		memcpy(rx_msg, msg, header.size << 2);
> +
> +	dev_ctx->temp_resp = (u32 *)rx_msg;
> +	dev_ctx->temp_resp_size = header.size;
> +
> +	/* Allow user to read */
> +	dev_ctx->pending_hdr = 1;
> +	wake_up_interruptible(&dev_ctx->wq);
> +
> +	if (is_response)
> +		priv->waiting_rsp_dev = NULL;
> +}
> +
> +int validate_rsp_hdr(struct se_if_priv *priv, u32 header,
> +		     uint8_t msg_id, uint8_t sz, bool is_base_api)
> +{
> +	int ret = -EINVAL;
> +	u32 size;
> +	u32 cmd;
> +	u32 tag;
> +	u32 ver;
> +
> +	tag = MSG_TAG(header);
> +	cmd = MSG_COMMAND(header);
> +	size = MSG_SIZE(header);
> +	ver = MSG_VER(header);
> +
> +	do {
> +		if (tag != priv->rsp_tag) {
> +			dev_err(priv->dev,
> +				"MSG[0x%x] Hdr: Resp tag mismatch. (0x%x != 0x%x)",
> +				msg_id, tag, priv->rsp_tag);
> +			break;
> +		}
> +
> +		if (cmd != msg_id) {
> +			dev_err(priv->dev,
> +				"MSG Header: Cmd id mismatch. (0x%x != 0x%x)",
> +				cmd, msg_id);
> +			break;
> +		}
> +
> +		if (size != (sz >> 2)) {
> +			dev_err(priv->dev,
> +				"MSG[0x%x] Hdr: Cmd size mismatch. (0x%x != 0x%x)",
> +				msg_id, size, (sz >> 2));
> +			break;
> +		}
> +
> +		if (is_base_api && (ver != priv->base_api_ver)) {
> +			dev_err(priv->dev,
> +				"MSG[0x%x] Hdr: Base API Vers mismatch. (0x%x != 0x%x)",
> +				msg_id, ver, priv->base_api_ver);
> +			break;
> +		} else if (!is_base_api && ver != priv->fw_api_ver) {
> +			dev_err(priv->dev,
> +				"MSG[0x%x] Hdr: FW API Vers mismatch. (0x%x != 0x%x)",
> +				msg_id, ver, priv->fw_api_ver);
> +			break;
> +		}
> +
> +		ret = 0;
> +
> +	} while (false);
> +
> +	return ret;
> +}
> +
> +int se_save_imem_state(struct device *dev)
> +{
> +	struct se_if_priv *priv = dev_get_drvdata(dev);
> +	int ret;
> +
> +	/* EXPORT command will save encrypted IMEM to given address,
> +	 * so later in resume, IMEM can be restored from the given
> +	 * address.
> +	 *
> +	 * Size must be at least 64 kB.
> +	 */
> +	ret = ele_service_swap(dev,
> +			       priv->imem.phyaddr,
> +			       ELE_IMEM_SIZE,
> +			       ELE_IMEM_EXPORT);
> +	if (ret < 0)
> +		dev_err(dev, "Failed to export IMEM\n");
> +	else
> +		dev_info(dev,
> +			"Exported %d bytes of encrypted IMEM\n",
> +			ret);
> +
> +	return ret;
> +}
> +
> +int se_restore_imem_state(struct device *dev)
> +{
> +	struct se_if_priv *priv = dev_get_drvdata(dev);
> +	struct soc_info s_info;
> +	int ret;
> +
> +	/* get info from ELE */
> +	ret = ele_get_info(dev, &s_info);
> +	if (ret) {
> +		dev_err(dev, "Failed to get info from ELE.\n");
> +		return ret;
> +	}
> +
> +	/* Get IMEM state, if 0xFE then import IMEM */
> +	if (s_info.imem_state == ELE_IMEM_STATE_BAD) {
> +		/* IMPORT command will restore IMEM from the given
> +		 * address, here size is the actual size returned by ELE
> +		 * during the export operation
> +		 */
> +		ret = ele_service_swap(dev,
> +				       priv->imem.phyaddr,
> +				       priv->imem.size,
> +				       ELE_IMEM_IMPORT);
> +		if (ret) {
> +			dev_err(dev, "Failed to import IMEM\n");
> +			goto exit;
> +		}
> +	} else
> +		goto exit;
> +
> +	/* After importing IMEM, check if IMEM state is equal to 0xCA
> +	 * to ensure IMEM is fully loaded and
> +	 * ELE functionality can be used.
> +	 */
> +	ret = ele_get_info(dev, &s_info);
> +	if (ret) {
> +		dev_err(dev, "Failed to get info from ELE.\n");
> +		goto exit;
> +	}
> +
> +	if (s_info.imem_state == ELE_IMEM_STATE_OK)
> +		dev_info(dev, "Successfully restored IMEM\n");
> +	else
> +		dev_err(dev, "Failed to restore IMEM\n");
> +
> +exit:
> +	return ret;
> +}
> diff --git a/drivers/firmware/imx/ele_common.h b/drivers/firmware/imx/ele_common.h
> new file mode 100644
> index 000000000000..6e3a2114bb56
> --- /dev/null
> +++ b/drivers/firmware/imx/ele_common.h
> @@ -0,0 +1,43 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +/*
> + * Copyright 2024 NXP
> + */
> +
> +
> +#ifndef __ELE_COMMON_H__
> +#define __ELE_COMMON_H__
> +
> +#include "se_ctrl.h"
> +
> +#define IMX_ELE_FW_DIR                 "imx/ele/"
> +
> +uint32_t plat_add_msg_crc(uint32_t *msg, uint32_t msg_len);
> +int imx_ele_miscdev_msg_rcv(struct se_if_device_ctx *priv);
> +int imx_ele_miscdev_msg_send(struct se_if_device_ctx *dev_ctx,
> +			     void *tx_msg, int tx_msg_sz);
> +int imx_ele_msg_rcv(struct se_if_priv *priv);
> +int imx_ele_msg_send(struct se_if_priv *priv, void *mssg);
> +int imx_ele_msg_send_rcv(struct se_if_priv *priv, void *mssg);
> +void se_if_rx_callback(struct mbox_client *mbox_cl, void *msg);
> +int validate_rsp_hdr(struct se_if_priv *priv, unsigned int header,
> +		     u8 msg_id, u8 sz, bool is_base_api);
> +
> +/* Fill a command message header with a given command ID and length in bytes. */
> +static inline int plat_fill_cmd_msg_hdr(struct se_if_priv *priv,
> +					struct se_msg_hdr *hdr,
> +					u8 cmd,
> +					u32 len,
> +					bool is_base_api)
> +{
> +	hdr->tag = priv->cmd_tag;
> +	hdr->ver = (is_base_api) ? priv->base_api_ver : priv->fw_api_ver;
> +	hdr->command = cmd;
> +	hdr->size = len >> 2;
> +
> +	return 0;
> +}
> +
> +int se_save_imem_state(struct device *dev);
> +int se_restore_imem_state(struct device *dev);
> +
> +#endif /*__ELE_COMMON_H__ */
> diff --git a/drivers/firmware/imx/se_ctrl.c b/drivers/firmware/imx/se_ctrl.c
> new file mode 100644
> index 000000000000..11c5eaa7353f
> --- /dev/null
> +++ b/drivers/firmware/imx/se_ctrl.c
> @@ -0,0 +1,1339 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright 2024 NXP
> + */
> +
> +#include <linux/completion.h>
> +#include <linux/delay.h>
> +#include <linux/dev_printk.h>
> +#include <linux/dma-mapping.h>
> +#include <linux/errno.h>
> +#include <linux/export.h>
> +#include <linux/firmware.h>
> +#include <linux/firmware/imx/se_api.h>
> +#include <linux/genalloc.h>
> +#include <linux/init.h>
> +#include <linux/io.h>
> +#include <linux/miscdevice.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/module.h>
> +#include <linux/of_platform.h>
> +#include <linux/of_reserved_mem.h>
> +#include <linux/platform_device.h>
> +#include <linux/slab.h>
> +#include <linux/string.h>
> +#include <linux/sys_soc.h>
> +#include <uapi/linux/se_ioctl.h>
> +
> +#include "ele_base_msg.h"
> +#include "ele_common.h"
> +#include "se_ctrl.h"
> +
> +#define RESERVED_DMA_POOL		BIT(1)
> +
> +struct imx_se_node_info {
> +	u8 se_if_id;
> +	u8 se_if_did;
> +	u8 max_dev_ctx;
> +	u8 cmd_tag;
> +	u8 rsp_tag;
> +	u8 success_tag;
> +	u8 base_api_ver;
> +	u8 fw_api_ver;
> +	u8 *se_name;
> +	u8 *mbox_tx_name;
> +	u8 *mbox_rx_name;
> +	u8 *pool_name;
> +	u8 *fw_name_in_rfs;
> +	bool soc_register;
> +	bool reserved_dma_ranges;
> +	bool imem_mgmt;
> +};
> +
> +struct imx_se_node_info_list {
> +	u8 num_mu;
> +	u16 soc_id;
> +	u16 soc_rev;
> +	struct imx_se_node_info info[];
> +};
> +
> +static const struct imx_se_node_info_list imx8ulp_info = {
> +	.num_mu = 1,
> +	.soc_id = SOC_ID_OF_IMX8ULP,
> +	.info = {
> +			{
> +				.se_if_id = 2,
> +				.se_if_did = 7,
> +				.max_dev_ctx = 4,
> +				.cmd_tag = 0x17,
> +				.rsp_tag = 0xe1,
> +				.success_tag = 0xd6,
> +				.base_api_ver = MESSAGING_VERSION_6,
> +				.fw_api_ver = MESSAGING_VERSION_7,
> +				.se_name = "hsm1",
> +				.mbox_tx_name = "tx",
> +				.mbox_rx_name = "rx",
> +				.pool_name = "sram",
> +				.fw_name_in_rfs = IMX_ELE_FW_DIR\
> +						  "mx8ulpa2ext-ahab-container.img",
> +				.soc_register = true,
> +				.reserved_dma_ranges = true,
> +				.imem_mgmt = true,
> +			},
> +	},
> +};
> +
> +static const struct imx_se_node_info_list imx93_info = {
> +	.num_mu = 1,
> +	.soc_id = SOC_ID_OF_IMX93,
> +	.info = {
> +			{
> +				.se_if_id = 2,
> +				.se_if_did = 3,
> +				.max_dev_ctx = 4,
> +				.cmd_tag = 0x17,
> +				.rsp_tag = 0xe1,
> +				.success_tag = 0xd6,
> +				.base_api_ver = MESSAGING_VERSION_6,
> +				.fw_api_ver = MESSAGING_VERSION_7,
> +				.se_name = "hsm1",
> +				.mbox_tx_name = "tx",
> +				.mbox_rx_name = "rx",
> +				.reserved_dma_ranges = true,
> +				.imem_mgmt = true,
> +				.soc_register = true,
> +			},
> +	},
> +};
> +
> +static const struct of_device_id se_match[] = {
> +	{ .compatible = "fsl,imx8ulp-ele", .data = (void *)&imx8ulp_info},
> +	{ .compatible = "fsl,imx93-ele", .data = (void *)&imx93_info},
> +	{},
> +};
> +
> +static struct imx_se_node_info
> +		*get_imx_se_node_info(struct imx_se_node_info_list *info_list,
> +				      const u32 idx)
> +{
> +	if (idx < 0 || idx > info_list->num_mu)
> +		return NULL;
> +
> +	return &info_list->info[idx];
> +}
> +
> +void *get_phy_buf_mem_pool(struct device *dev,
> +			   u8 *mem_pool_name,
> +			   dma_addr_t *buf,
> +			   u32 size)
> +{
> +	struct device_node *of_node = dev->of_node;
> +	struct gen_pool *mem_pool;
> +
> +	mem_pool = of_gen_pool_get(of_node, mem_pool_name, 0);
> +	if (!mem_pool) {
> +		dev_err(dev,
> +			"Unable to get sram pool = %s\n",
> +			mem_pool_name);
> +		return 0;
> +	}
> +
> +	return gen_pool_dma_alloc(mem_pool, size, buf);
> +}
> +
> +void free_phybuf_mem_pool(struct device *dev,
> +			  u8 *mem_pool_name,
> +			  u32 *buf,
> +			  u32 size)
> +{
> +	struct device_node *of_node = dev->of_node;
> +	struct gen_pool *mem_pool;
> +
> +	mem_pool = of_gen_pool_get(of_node, mem_pool_name, 0);
> +	if (!mem_pool)
> +		dev_err(dev,
> +			"%s: Failed: Unable to get sram pool.\n",
> +			__func__);
> +
> +	gen_pool_free(mem_pool, (u64)buf, size);
> +}
> +
> +static int imx_fetch_soc_info(struct device *dev)
> +{
> +	struct se_if_priv *priv = dev_get_drvdata(dev);
> +	struct imx_se_node_info_list *info_list;
> +	const struct imx_se_node_info *info;
> +	struct soc_device_attribute *attr;
> +	struct soc_device *sdev;
> +	struct soc_info s_info;
> +	int err = 0;
> +
> +	info = priv->info;
> +	info_list = (struct imx_se_node_info_list *)
> +				device_get_match_data(dev->parent);
> +	if (info_list->soc_rev)
> +		return err;
> +
> +	err = ele_get_info(dev, &s_info);
> +	if (err)
> +		s_info.major_ver = DEFAULT_IMX_SOC_VER;
> +
> +	info_list->soc_rev = s_info.soc_rev;
> +
> +	if (!info->soc_register)
> +		return 0;
> +
> +	attr = devm_kzalloc(dev, sizeof(*attr), GFP_KERNEL);
> +	if (!attr)
> +		return -ENOMEM;
> +
> +	if (s_info.minor_ver)
> +		attr->revision = devm_kasprintf(dev, GFP_KERNEL, "%x.%x",
> +					   s_info.major_ver,
> +					   s_info.minor_ver);
> +	else
> +		attr->revision = devm_kasprintf(dev, GFP_KERNEL, "%x",
> +					   s_info.major_ver);
> +
> +	switch (s_info.soc_id) {
> +	case SOC_ID_OF_IMX8ULP:
> +		attr->soc_id = devm_kasprintf(dev, GFP_KERNEL,
> +					      "i.MX8ULP");
> +		break;
> +	case SOC_ID_OF_IMX93:
> +		attr->soc_id = devm_kasprintf(dev, GFP_KERNEL,
> +					      "i.MX93");
> +		break;
> +	}
> +
> +	err = of_property_read_string(of_root, "model",
> +				      &attr->machine);
> +	if (err) {
> +		devm_kfree(dev, attr);
> +		return -EINVAL;
> +	}
> +	attr->family = devm_kasprintf(dev, GFP_KERNEL, "Freescale i.MX");
> +
> +	attr->serial_number
> +		= devm_kasprintf(dev, GFP_KERNEL, "%016llX", s_info.serial_num);
> +
> +	sdev = soc_device_register(attr);
> +	if (IS_ERR(sdev)) {
> +		devm_kfree(dev, attr->soc_id);
> +		devm_kfree(dev, attr->serial_number);
> +		devm_kfree(dev, attr->revision);
> +		devm_kfree(dev, attr->family);
> +		devm_kfree(dev, attr->machine);
> +		devm_kfree(dev, attr);
> +		return PTR_ERR(sdev);
> +	}
> +
> +	return 0;
> +}
> +
> +/*
> + * File operations for user-space
> + */
> +
> +/* Write a message to the MU. */
> +static ssize_t se_if_fops_write(struct file *fp, const char __user *buf,
> +				size_t size, loff_t *ppos)
> +{
> +	struct se_api_msg *tx_msg __free(kfree);
> +	struct se_if_device_ctx *dev_ctx;
> +	struct se_if_priv *priv;
> +	int err;
> +
> +	dev_ctx = container_of(fp->private_data,
> +			       struct se_if_device_ctx,
> +			       miscdev);
> +	priv = dev_ctx->priv;
> +	dev_dbg(priv->dev,
> +		"%s: write from buf (%p)%zu, ppos=%lld\n",
> +			dev_ctx->miscdev.name,
> +			buf, size, ((ppos) ? *ppos : 0));
> +
> +	if (down_interruptible(&dev_ctx->fops_lock))
> +		return -EBUSY;
> +
> +	if (dev_ctx->status != MU_OPENED) {
> +		err = -EINVAL;
> +		goto exit;
> +	}
> +
> +	if (size < SE_MU_HDR_SZ) {
> +		dev_err(priv->dev,
> +			"%s: User buffer too small(%zu < %d)\n",
> +				dev_ctx->miscdev.name,
> +				size, SE_MU_HDR_SZ);
> +		err = -ENOSPC;
> +		goto exit;
> +	}
> +
> +	tx_msg = memdup_user((void __user *)ppos, size);
> +	if (!tx_msg) {
> +		err = -ENOMEM;
> +		goto exit;
> +	}
> +
> +	/* Copy data to buffer */
> +	if (copy_from_user(tx_msg, buf, size)) {
> +		err = -EFAULT;
> +		dev_err(priv->dev,
> +			"%s: Fail copy message from user\n",
> +				dev_ctx->miscdev.name);
> +		goto exit;
> +	}
> +
> +	print_hex_dump_debug("from user ", DUMP_PREFIX_OFFSET, 4, 4,
> +			     tx_msg, size, false);
> +
> +	err = imx_ele_miscdev_msg_send(dev_ctx, tx_msg, size);
> +
> +exit:
> +	up(&dev_ctx->fops_lock);
> +	return err;
> +}
> +
> +/*
> + * Read a message from the MU.
> + * Blocking until a message is available.
> + */
> +static ssize_t se_if_fops_read(struct file *fp, char __user *buf,
> +			       size_t size, loff_t *ppos)
> +{
> +	struct se_if_device_ctx *dev_ctx;
> +	struct se_buf_desc *b_desc;
> +	struct se_if_priv *priv;
> +	u32 size_to_copy;
> +	int err;
> +
> +	dev_ctx = container_of(fp->private_data,
> +			       struct se_if_device_ctx,
> +			       miscdev);
> +	priv = dev_ctx->priv;
> +	dev_dbg(priv->dev,
> +		"%s: read to buf %p(%zu), ppos=%lld\n",
> +			dev_ctx->miscdev.name,
> +			buf, size, ((ppos) ? *ppos : 0));
> +
> +	if (down_interruptible(&dev_ctx->fops_lock))
> +		return -EBUSY;
> +
> +	if (dev_ctx->status != MU_OPENED) {
> +		err = -EINVAL;
> +		goto exit;
> +	}
> +
> +	err = imx_ele_miscdev_msg_rcv(dev_ctx);
> +	if (err)
> +		goto exit;
> +
> +	/* Buffer containing the message from FW, is
> +	 * allocated in callback function.
> +	 * Check if buffer allocation failed.
> +	 */
> +	if (!dev_ctx->temp_resp) {
> +		err = -ENOMEM;
> +		goto exit;
> +	}
> +
> +	dev_dbg(priv->dev,
> +			"%s: %s %s\n",
> +			dev_ctx->miscdev.name,
> +			__func__,
> +			"message received, start transmit to user");
> +
> +	/*
> +	 * Check that the size passed as argument is larger than
> +	 * the one carried in the message.
> +	 */
> +	size_to_copy = dev_ctx->temp_resp_size << 2;
> +	if (size_to_copy > size) {
> +		dev_dbg(priv->dev,
> +			"%s: User buffer too small (%zu < %d)\n",
> +				dev_ctx->miscdev.name,
> +				size, size_to_copy);
> +		size_to_copy = size;
> +	}
> +
> +	/*
> +	 * We may need to copy the output data to user before
> +	 * delivering the completion message.
> +	 */
> +	while (!list_empty(&dev_ctx->pending_out)) {
> +		b_desc = list_first_entry_or_null(&dev_ctx->pending_out,
> +						  struct se_buf_desc,
> +						  link);
> +		if (!b_desc)
> +			continue;
> +
> +		if (b_desc->usr_buf_ptr && b_desc->shared_buf_ptr) {
> +
> +			dev_dbg(priv->dev,
> +				"%s: Copy output data to user\n",
> +				dev_ctx->miscdev.name);
> +			if (copy_to_user(b_desc->usr_buf_ptr,
> +					 b_desc->shared_buf_ptr,
> +					 b_desc->size)) {
> +				dev_err(priv->dev,
> +					"%s: Failure copying output data to user.",
> +					dev_ctx->miscdev.name);
> +				err = -EFAULT;
> +				goto exit;
> +			}
> +		}
> +
> +		if (b_desc->shared_buf_ptr)
> +			memset(b_desc->shared_buf_ptr, 0, b_desc->size);
> +
> +		__list_del_entry(&b_desc->link);
> +		kfree(b_desc);
> +	}
> +
> +	/* Copy data from the buffer */
> +	print_hex_dump_debug("to user ", DUMP_PREFIX_OFFSET, 4, 4,
> +			     dev_ctx->temp_resp, size_to_copy, false);
> +	if (copy_to_user(buf, dev_ctx->temp_resp, size_to_copy)) {
> +		dev_err(priv->dev,
> +			"%s: Failed to copy to user\n",
> +				dev_ctx->miscdev.name);
> +		err = -EFAULT;
> +		goto exit;
> +	}
> +
> +	err = size_to_copy;
> +	kfree(dev_ctx->temp_resp);
> +
> +	/* free memory allocated on the shared buffers. */
> +	dev_ctx->secure_mem.pos = 0;
> +	dev_ctx->non_secure_mem.pos = 0;
> +
> +	dev_ctx->pending_hdr = 0;
> +
> +exit:
> +	/*
> +	 * Clean the used Shared Memory space,
> +	 * whether its Input Data copied from user buffers, or
> +	 * Data received from FW.
> +	 */
> +	while (!list_empty(&dev_ctx->pending_in) ||
> +	       !list_empty(&dev_ctx->pending_out)) {
> +		if (!list_empty(&dev_ctx->pending_in))
> +			b_desc = list_first_entry_or_null(&dev_ctx->pending_in,
> +							  struct se_buf_desc,
> +							  link);
> +		else
> +			b_desc = list_first_entry_or_null(&dev_ctx->pending_out,
> +							  struct se_buf_desc,
> +							  link);
> +
> +		if (!b_desc)
> +			continue;
> +
> +		if (b_desc->shared_buf_ptr)
> +			memset(b_desc->shared_buf_ptr, 0, b_desc->size);
> +
> +		__list_del_entry(&b_desc->link);
> +		kfree(b_desc);
> +	}
> +
> +	up(&dev_ctx->fops_lock);
> +	return err;
> +}
> +
> +/* Give access to EdgeLock Enclave, to the memory we want to share */
> +static int se_if_setup_se_mem_access(struct se_if_device_ctx *dev_ctx,
> +				     u64 addr, u32 len)
> +{
> +	/* Assuming EdgeLock Enclave has access to all the memory regions */
> +	int ret = 0;
> +
> +	if (ret) {
> +		dev_err(dev_ctx->priv->dev,
> +			"%s: Fail find memreg\n", dev_ctx->miscdev.name);
> +		goto exit;
> +	}
> +
> +	if (ret) {
> +		dev_err(dev_ctx->priv->dev,
> +			"%s: Fail set permission for resource\n",
> +				dev_ctx->miscdev.name);
> +		goto exit;
> +	}
> +
> +exit:
> +	return ret;
> +}
> +
> +static int se_ioctl_get_mu_info(struct se_if_device_ctx *dev_ctx,
> +				u64 arg)
> +{
> +	struct se_if_priv *priv = dev_get_drvdata(dev_ctx->dev);
> +	struct imx_se_node_info *if_node_info;
> +	struct se_ioctl_get_if_info info;
> +	int err = 0;
> +
> +	if_node_info = (struct imx_se_node_info *)priv->info;
> +
> +	info.se_if_id = if_node_info->se_if_id;
> +	info.interrupt_idx = 0;
> +	info.tz = 0;
> +	info.did = if_node_info->se_if_did;
> +	info.cmd_tag = if_node_info->cmd_tag;
> +	info.rsp_tag = if_node_info->rsp_tag;
> +	info.success_tag = if_node_info->success_tag;
> +	info.base_api_ver = if_node_info->base_api_ver;
> +	info.fw_api_ver = if_node_info->fw_api_ver;
> +
> +	dev_dbg(priv->dev,
> +		"%s: info [se_if_id: %d, irq_idx: %d, tz: 0x%x, did: 0x%x]\n",
> +			dev_ctx->miscdev.name,
> +			info.se_if_id, info.interrupt_idx, info.tz, info.did);
> +
> +	if (copy_to_user((u8 *)arg, &info, sizeof(info))) {
> +		dev_err(dev_ctx->priv->dev,
> +			"%s: Failed to copy mu info to user\n",
> +				dev_ctx->miscdev.name);
> +		err = -EFAULT;
> +		goto exit;
> +	}
> +
> +exit:
> +	return err;
> +}
> +
> +/*
> + * Copy a buffer of data to/from the user and return the address to use in
> + * messages
> + */
> +static int se_ioctl_setup_iobuf_handler(struct se_if_device_ctx *dev_ctx,
> +					    u64 arg)
> +{
> +	struct se_ioctl_setup_iobuf io = {0};
> +	struct se_shared_mem *shared_mem;
> +	struct se_buf_desc *b_desc;
> +	int err = 0;
> +	u32 pos;
> +
> +	if (copy_from_user(&io, (u8 *)arg, sizeof(io))) {
> +		dev_err(dev_ctx->priv->dev,
> +			"%s: Failed copy iobuf config from user\n",
> +				dev_ctx->miscdev.name);
> +		err = -EFAULT;
> +		goto exit;
> +	}
> +
> +	dev_dbg(dev_ctx->priv->dev,
> +			"%s: io [buf: %p(%d) flag: %x]\n",
> +			dev_ctx->miscdev.name,
> +			io.user_buf, io.length, io.flags);
> +
> +	if (io.length == 0 || !io.user_buf) {
> +		/*
> +		 * Accept NULL pointers since some buffers are optional
> +		 * in FW commands. In this case we should return 0 as
> +		 * pointer to be embedded into the message.
> +		 * Skip all data copy part of code below.
> +		 */
> +		io.ele_addr = 0;
> +		goto copy;
> +	}
> +
> +	/* Select the shared memory to be used for this buffer. */
> +	if (io.flags & SE_MU_IO_FLAGS_USE_SEC_MEM) {
> +		/* App requires to use secure memory for this buffer.*/
> +		dev_err(dev_ctx->priv->dev,
> +			"%s: Failed allocate SEC MEM memory\n",
> +				dev_ctx->miscdev.name);
> +		err = -EFAULT;
> +		goto exit;
> +	} else {
> +		/* No specific requirement for this buffer. */
> +		shared_mem = &dev_ctx->non_secure_mem;
> +	}
> +
> +	/* Check there is enough space in the shared memory. */
> +	if (shared_mem->size < shared_mem->pos
> +			|| io.length >= shared_mem->size - shared_mem->pos) {
> +		dev_err(dev_ctx->priv->dev,
> +			"%s: Not enough space in shared memory\n",
> +				dev_ctx->miscdev.name);
> +		err = -ENOMEM;
> +		goto exit;
> +	}
> +
> +	/* Allocate space in shared memory. 8 bytes aligned. */
> +	pos = shared_mem->pos;
> +	shared_mem->pos += round_up(io.length, 8u);
> +	io.ele_addr = (u64)shared_mem->dma_addr + pos;
> +
> +	if ((io.flags & SE_MU_IO_FLAGS_USE_SEC_MEM) &&
> +	    !(io.flags & SE_MU_IO_FLAGS_USE_SHORT_ADDR)) {
> +		/*Add base address to get full address.*/
> +		dev_err(dev_ctx->priv->dev,
> +			"%s: Failed allocate SEC MEM memory\n",
> +				dev_ctx->miscdev.name);
> +		err = -EFAULT;
> +		goto exit;
> +	}
> +
> +	memset(shared_mem->ptr + pos, 0, io.length);
> +	if ((io.flags & SE_IO_BUF_FLAGS_IS_INPUT) ||
> +	    (io.flags & SE_IO_BUF_FLAGS_IS_IN_OUT)) {
> +		/*
> +		 * buffer is input:
> +		 * copy data from user space to this allocated buffer.
> +		 */
> +		if (copy_from_user(shared_mem->ptr + pos, io.user_buf,
> +				   io.length)) {
> +			dev_err(dev_ctx->priv->dev,
> +				"%s: Failed copy data to shared memory\n",
> +				dev_ctx->miscdev.name);
> +			err = -EFAULT;
> +			goto exit;
> +		}
> +	}
> +
> +	b_desc = kzalloc(sizeof(*b_desc), GFP_KERNEL);
> +	if (!b_desc) {
> +		err = -ENOMEM;
> +		goto exit;
> +	}
> +
> +copy:
> +	/* Provide the EdgeLock Enclave address to user space only if success.*/
> +	if (copy_to_user((u8 *)arg, &io, sizeof(io))) {
> +		dev_err(dev_ctx->priv->dev,
> +			"%s: Failed to copy iobuff setup to user\n",
> +				dev_ctx->miscdev.name);
> +		kfree(b_desc);
> +		err = -EFAULT;
> +		goto exit;
> +	}
> +
> +	if (b_desc) {
> +		b_desc->shared_buf_ptr = shared_mem->ptr + pos;
> +		b_desc->usr_buf_ptr = io.user_buf;
> +		b_desc->size = io.length;
> +
> +		if (io.flags & SE_IO_BUF_FLAGS_IS_INPUT) {
> +			/*
> +			 * buffer is input:
> +			 * add an entry in the "pending input buffers" list so
> +			 * that copied data can be cleaned from shared memory
> +			 * later.
> +			 */
> +			list_add_tail(&b_desc->link, &dev_ctx->pending_in);
> +		} else {
> +			/*
> +			 * buffer is output:
> +			 * add an entry in the "pending out buffers" list so data
> +			 * can be copied to user space when receiving Secure-Enclave
> +			 * response.
> +			 */
> +			list_add_tail(&b_desc->link, &dev_ctx->pending_out);
> +		}
> +	}
> +
> +exit:
> +	return err;
> +}
> +
> +/* IOCTL to provide SoC information */
> +static int se_ioctl_get_soc_info_handler(struct se_if_device_ctx *dev_ctx,
> +					     u64 arg)
> +{
> +	struct imx_se_node_info_list *info_list;
> +	struct se_ioctl_get_soc_info soc_info;
> +	int err = -EINVAL;
> +
> +	info_list = (struct imx_se_node_info_list *)
> +			device_get_match_data(dev_ctx->priv->dev->parent);
> +	if (!info_list)
> +		goto exit;
> +
> +	soc_info.soc_id = info_list->soc_id;
> +	soc_info.soc_rev = info_list->soc_rev;
> +
> +	err = (int)copy_to_user((u8 *)arg, (u8 *)(&soc_info), sizeof(soc_info));
> +	if (err) {
> +		dev_err(dev_ctx->priv->dev,
> +			"%s: Failed to copy soc info to user\n",
> +			dev_ctx->miscdev.name);
> +		err = -EFAULT;
> +		goto exit;
> +	}
> +
> +exit:
> +	return err;
> +}
> +
> +/* Open a character device. */
> +static int se_if_fops_open(struct inode *nd, struct file *fp)
> +{
> +	struct se_if_device_ctx *dev_ctx = container_of(fp->private_data,
> +							struct se_if_device_ctx,
> +							miscdev);
> +	int err;
> +
> +	/* Avoid race if opened at the same time */
> +	if (down_trylock(&dev_ctx->fops_lock))
> +		return -EBUSY;
> +
> +	/* Authorize only 1 instance. */
> +	if (dev_ctx->status != MU_FREE) {
> +		err = -EBUSY;
> +		goto exit;
> +	}
> +
> +	/*
> +	 * Allocate some memory for data exchanges with S40x.
> +	 * This will be used for data not requiring secure memory.
> +	 */
> +	dev_ctx->non_secure_mem.ptr = dmam_alloc_coherent(dev_ctx->dev,
> +					MAX_DATA_SIZE_PER_USER,
> +					&dev_ctx->non_secure_mem.dma_addr,
> +					GFP_KERNEL);
> +	if (!dev_ctx->non_secure_mem.ptr) {
> +		err = -ENOMEM;
> +		goto exit;
> +	}
> +
> +	err = se_if_setup_se_mem_access(dev_ctx,
> +					  dev_ctx->non_secure_mem.dma_addr,
> +					  MAX_DATA_SIZE_PER_USER);
> +	if (err) {
> +		err = -EPERM;
> +		dev_err(dev_ctx->priv->dev,
> +			"%s: Failed to share access to shared memory\n",
> +			   dev_ctx->miscdev.name);
> +		goto free_coherent;
> +	}
> +
> +	dev_ctx->non_secure_mem.size = MAX_DATA_SIZE_PER_USER;
> +	dev_ctx->non_secure_mem.pos = 0;
> +	dev_ctx->status = MU_OPENED;
> +
> +	dev_ctx->pending_hdr = 0;
> +
> +	goto exit;
> +
> +free_coherent:
> +	dmam_free_coherent(dev_ctx->priv->dev, MAX_DATA_SIZE_PER_USER,
> +			   dev_ctx->non_secure_mem.ptr,
> +			   dev_ctx->non_secure_mem.dma_addr);
> +
> +exit:
> +	up(&dev_ctx->fops_lock);
> +	return err;
> +}
> +
> +/* Close a character device. */
> +static int se_if_fops_close(struct inode *nd, struct file *fp)
> +{
> +	struct se_if_device_ctx *dev_ctx = container_of(fp->private_data,
> +							struct se_if_device_ctx,
> +							miscdev);
> +	struct se_if_priv *priv = dev_ctx->priv;
> +	struct se_buf_desc *b_desc;
> +
> +	/* Avoid race if closed at the same time */
> +	if (down_trylock(&dev_ctx->fops_lock))
> +		return -EBUSY;
> +
> +	/* The device context has not been opened */
> +	if (dev_ctx->status != MU_OPENED)
> +		goto exit;
> +
> +	/* check if this device was registered as command receiver. */
> +	if (priv->cmd_receiver_dev == dev_ctx)
> +		priv->cmd_receiver_dev = NULL;
> +
> +	/* check if this device was registered as waiting response. */
> +	if (priv->waiting_rsp_dev == dev_ctx) {
> +		priv->waiting_rsp_dev = NULL;
> +		mutex_unlock(&priv->se_if_cmd_lock);
> +	}
> +
> +	/* Unmap secure memory shared buffer. */
> +	if (dev_ctx->secure_mem.ptr)
> +		devm_iounmap(dev_ctx->dev, dev_ctx->secure_mem.ptr);
> +
> +	dev_ctx->secure_mem.ptr = NULL;
> +	dev_ctx->secure_mem.dma_addr = 0;
> +	dev_ctx->secure_mem.size = 0;
> +	dev_ctx->secure_mem.pos = 0;
> +
> +	/* Free non-secure shared buffer. */
> +	dmam_free_coherent(dev_ctx->priv->dev, MAX_DATA_SIZE_PER_USER,
> +			   dev_ctx->non_secure_mem.ptr,
> +			   dev_ctx->non_secure_mem.dma_addr);
> +
> +	dev_ctx->non_secure_mem.ptr = NULL;
> +	dev_ctx->non_secure_mem.dma_addr = 0;
> +	dev_ctx->non_secure_mem.size = 0;
> +	dev_ctx->non_secure_mem.pos = 0;
> +
> +	while (!list_empty(&dev_ctx->pending_in) ||
> +	       !list_empty(&dev_ctx->pending_out)) {
> +		if (!list_empty(&dev_ctx->pending_in))
> +			b_desc = list_first_entry_or_null(&dev_ctx->pending_in,
> +							  struct se_buf_desc,
> +							  link);
> +		else
> +			b_desc = list_first_entry_or_null(&dev_ctx->pending_out,
> +							  struct se_buf_desc,
> +							  link);
> +
> +		if (!b_desc)
> +			continue;
> +
> +		if (b_desc->shared_buf_ptr)
> +			memset(b_desc->shared_buf_ptr, 0, b_desc->size);
> +
> +		__list_del_entry(&b_desc->link);
> +		devm_kfree(dev_ctx->dev, b_desc);
> +	}
> +
> +	dev_ctx->status = MU_FREE;
> +
> +exit:
> +	up(&dev_ctx->fops_lock);
> +	return 0;
> +}
> +
> +/* IOCTL entry point of a character device */
> +static long se_ioctl(struct file *fp, unsigned int cmd, unsigned long arg)
> +//static long se_ioctl(struct file *fp, u32 cmd, u64 arg)
> +{
> +	struct se_if_device_ctx *dev_ctx = container_of(fp->private_data,
> +							struct se_if_device_ctx,
> +							miscdev);
> +	struct se_if_priv *se_if_priv = dev_ctx->priv;
> +	int err = -EINVAL;
> +
> +	/* Prevent race during change of device context */
> +	if (down_interruptible(&dev_ctx->fops_lock))
> +		return -EBUSY;
> +
> +	switch (cmd) {
> +	case SE_IOCTL_ENABLE_CMD_RCV:
> +		if (!se_if_priv->cmd_receiver_dev) {
> +			se_if_priv->cmd_receiver_dev = dev_ctx;
> +			err = 0;
> +		}
> +		break;
> +	case SE_IOCTL_GET_MU_INFO:
> +		err = se_ioctl_get_mu_info(dev_ctx, arg);
> +		break;
> +	case SE_IOCTL_SETUP_IOBUF:
> +		err = se_ioctl_setup_iobuf_handler(dev_ctx, arg);
> +		break;
> +	case SE_IOCTL_GET_SOC_INFO:
> +		err = se_ioctl_get_soc_info_handler(dev_ctx, arg);
> +		break;
> +
> +	default:
> +		err = -EINVAL;
> +		dev_dbg(se_if_priv->dev,
> +			"%s: IOCTL %.8x not supported\n",
> +				dev_ctx->miscdev.name,
> +				cmd);
> +	}
> +
> +	up(&dev_ctx->fops_lock);
> +	return (long)err;
> +}
> +
> +/* Char driver setup */
> +static const struct file_operations se_if_fops = {
> +	.open		= se_if_fops_open,
> +	.owner		= THIS_MODULE,
> +	.release	= se_if_fops_close,
> +	.unlocked_ioctl = se_ioctl,
> +	.read		= se_if_fops_read,
> +	.write		= se_if_fops_write,
> +};
> +
> +/* interface for managed res to free a mailbox channel */
> +static void if_mbox_free_channel(void *mbox_chan)
> +{
> +	mbox_free_channel(mbox_chan);
> +}
> +
> +/* interface for managed res to unregister a character device */
> +static void if_misc_deregister(void *miscdevice)
> +{
> +	misc_deregister(miscdevice);
> +}
> +
> +static int se_if_request_channel(struct device *dev,
> +				 struct mbox_chan **chan,
> +				 struct mbox_client *cl,
> +				 const u8 *name)
> +{
> +	struct mbox_chan *t_chan;
> +	int ret = 0;
> +
> +	t_chan = mbox_request_channel_byname(cl, name);
> +	if (IS_ERR(t_chan)) {
> +		ret = PTR_ERR(t_chan);
> +		if (ret != -EPROBE_DEFER)
> +			dev_err(dev,
> +				"Failed to request chan %s ret %d\n", name,
> +				ret);
> +		goto exit;
> +	}
> +
> +	ret = devm_add_action(dev, if_mbox_free_channel, t_chan);
> +	if (ret) {
> +		dev_err(dev, "failed to add devm removal of mbox %s\n", name);
> +		goto exit;
> +	}
> +
> +	*chan = t_chan;
> +
> +exit:
> +	return ret;
> +}
> +
> +static int se_probe_if_cleanup(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct se_if_priv *priv;
> +	int ret = 0;
> +	int i;
> +
> +	priv = dev_get_drvdata(dev);
> +	if (!priv) {
> +		ret = 0;
> +		dev_dbg(dev, "SE-MU Priv data is NULL;");
> +		return ret;
> +	}
> +
> +	if (priv->tx_chan)
> +		mbox_free_channel(priv->tx_chan);
> +	if (priv->rx_chan)
> +		mbox_free_channel(priv->rx_chan);
> +
> +	/* free the buffer in se remove, previously allocated
> +	 * in se probe to store encrypted IMEM
> +	 */
> +	if (priv->imem.buf) {
> +		dmam_free_coherent(dev,
> +				   ELE_IMEM_SIZE,
> +				   priv->imem.buf,
> +				   priv->imem.phyaddr);
> +		priv->imem.buf = NULL;
> +	}
> +
> +	if (priv->ctxs) {
> +		for (i = 0; i < priv->max_dev_ctx; i++) {
> +			if (priv->ctxs[i]) {
> +				devm_remove_action(dev,
> +						   if_misc_deregister,
> +						   &priv->ctxs[i]->miscdev);
> +				misc_deregister(&priv->ctxs[i]->miscdev);
> +				devm_kfree(dev, priv->ctxs[i]);
> +			}
> +		}
> +		devm_kfree(dev, priv->ctxs);
> +	}
> +
> +	if (priv->flags & RESERVED_DMA_POOL) {
> +		of_reserved_mem_device_release(dev);
> +		priv->flags &= (~RESERVED_DMA_POOL);
> +	}
> +
> +	devm_kfree(dev, priv);
> +	of_node_put(dev->of_node);
> +	of_platform_device_destroy(dev, NULL);
> +
> +	return ret;
> +}
> +
> +static int se_probe_cleanup(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct device_node *if_dn;
> +
> +	/* Enumerate se-interface device nodes. */
> +	for_each_child_of_node(dev->of_node, if_dn) {
> +		struct platform_device *if_pdev
> +					= of_find_device_by_node(if_dn);
> +		if (se_probe_if_cleanup(if_pdev))
> +			dev_err(dev,
> +				"Failed to clean-up child node probe.\n");
> +	}
> +
> +	return 0;
> +}
> +
> +static int init_device_context(struct device *dev)
> +{
> +	const struct imx_se_node_info *info;
> +	struct se_if_device_ctx *dev_ctx;
> +	struct se_if_priv *priv;
> +	u8 *devname;
> +	int ret = 0;
> +	int i;
> +
> +	priv = dev_get_drvdata(dev);
> +
> +	if (!priv) {
> +		ret = -EINVAL;
> +		dev_err(dev, "Invalid SE-MU Priv data");
> +		return ret;
> +	}
> +	info = priv->info;
> +
> +	priv->ctxs = devm_kzalloc(dev, sizeof(dev_ctx) * priv->max_dev_ctx,
> +				  GFP_KERNEL);
> +
> +	if (!priv->ctxs) {
> +		ret = -ENOMEM;
> +		return ret;
> +	}
> +
> +	/* Create users */
> +	for (i = 0; i < priv->max_dev_ctx; i++) {
> +		dev_ctx = devm_kzalloc(dev, sizeof(*dev_ctx), GFP_KERNEL);
> +		if (!dev_ctx) {
> +			ret = -ENOMEM;
> +			return ret;
> +		}
> +
> +		dev_ctx->dev = dev;
> +		dev_ctx->status = MU_FREE;
> +		dev_ctx->priv = priv;
> +
> +		priv->ctxs[i] = dev_ctx;
> +
> +		/* Default value invalid for an header. */
> +		init_waitqueue_head(&dev_ctx->wq);
> +
> +		INIT_LIST_HEAD(&dev_ctx->pending_out);
> +		INIT_LIST_HEAD(&dev_ctx->pending_in);
> +		sema_init(&dev_ctx->fops_lock, 1);
> +
> +		devname = devm_kasprintf(dev, GFP_KERNEL, "%s_ch%d",
> +					 info->se_name, i);
> +		if (!devname) {
> +			ret = -ENOMEM;
> +			return ret;
> +		}
> +
> +		dev_ctx->miscdev.name = devname;
> +		dev_ctx->miscdev.minor = MISC_DYNAMIC_MINOR;
> +		dev_ctx->miscdev.fops = &se_if_fops;
> +		dev_ctx->miscdev.parent = dev;
> +		ret = misc_register(&dev_ctx->miscdev);
> +		if (ret) {
> +			dev_err(dev, "failed to register misc device %d\n",
> +				ret);
> +			return ret;
> +		}
> +
> +		ret = devm_add_action(dev, if_misc_deregister,
> +				      &dev_ctx->miscdev);
> +		if (ret) {
> +			dev_err(dev,
> +				"failed[%d] to add action to the misc-dev\n",
> +				ret);
> +			return ret;
> +		}
> +	}
> +
> +	return ret;
> +}
> +
> +static void se_load_firmware(const struct firmware *fw, void *context)
> +{
> +	struct se_if_priv *priv = (struct se_if_priv *) context;
> +	const struct imx_se_node_info *info = priv->info;
> +	const u8 *se_fw_name = info->fw_name_in_rfs;
> +	phys_addr_t se_fw_phyaddr;
> +	u8 *se_fw_buf;
> +
> +	if (!fw) {
> +		if (priv->fw_fail > MAX_FW_LOAD_RETRIES)
> +			dev_dbg(priv->dev,
> +				 "External FW not found, using ROM FW.\n");
> +		else {
> +			/*add a bit delay to wait for firmware priv released */
> +			msleep(20);
> +
> +			/* Load firmware one more time if timeout */
> +			request_firmware_nowait(THIS_MODULE,
> +					FW_ACTION_UEVENT, info->fw_name_in_rfs,
> +					priv->dev, GFP_KERNEL, priv,
> +					se_load_firmware);
> +			priv->fw_fail++;
> +			dev_dbg(priv->dev, "Value of retries = 0x%x.\n",
> +				priv->fw_fail);
> +		}
> +
> +		return;
> +	}
> +
> +	/* allocate buffer to store the SE FW */
> +	se_fw_buf = dmam_alloc_coherent(priv->dev, fw->size,
> +					 &se_fw_phyaddr,
> +					 GFP_KERNEL);
> +	if (!se_fw_buf) {
> +		dev_err(priv->dev, "Failed to alloc SE fw buffer memory\n");
> +		goto exit;
> +	}
> +
> +	memcpy(se_fw_buf, fw->data, fw->size);
> +
> +	if (ele_fw_authenticate(priv->dev, se_fw_phyaddr))
> +		dev_err(priv->dev,
> +			"Failed to authenticate & load SE firmware %s.\n",
> +			se_fw_name);
> +
> +exit:
> +	dmam_free_coherent(priv->dev,
> +			   fw->size,
> +			   se_fw_buf,
> +			   se_fw_phyaddr);
> +
> +	release_firmware(fw);
> +}
> +
> +static int se_if_probe(struct platform_device *pdev)
> +{
> +	struct imx_se_node_info_list *info_list;
> +	struct device *dev = &pdev->dev;
> +	struct imx_se_node_info *info;
> +	struct se_if_priv *priv;
> +	u32 idx;
> +	int ret;
> +
> +	if (of_property_read_u32(dev->of_node, "reg", &idx)) {
> +		ret = -EINVAL;
> +		goto exit;
> +	}
> +
> +	info_list = (struct imx_se_node_info_list *)
> +			device_get_match_data(dev->parent);
> +	info = get_imx_se_node_info(info_list, idx);
> +
> +	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> +	if (!priv) {
> +		ret = -ENOMEM;
> +		goto exit;
> +	}
> +
> +	dev_set_drvdata(dev, priv);
> +
> +	/* Mailbox client configuration */
> +	priv->se_mb_cl.dev		= dev;
> +	priv->se_mb_cl.tx_block		= false;
> +	priv->se_mb_cl.knows_txdone	= true;
> +	priv->se_mb_cl.rx_callback	= se_if_rx_callback;
> +
> +	ret = se_if_request_channel(dev, &priv->tx_chan,
> +			&priv->se_mb_cl, info->mbox_tx_name);
> +	if (ret) {
> +		if (ret == -EPROBE_DEFER)
> +			dev_err(dev, "Mailbox tx channel, is not ready.\n");
> +		else
> +			dev_err(dev, "Failed to request tx channel\n");
> +
> +		goto exit;
> +	}
> +
> +	ret = se_if_request_channel(dev, &priv->rx_chan,
> +			&priv->se_mb_cl, info->mbox_rx_name);
> +	if (ret) {
> +		if (ret == -EPROBE_DEFER)
> +			dev_err(dev, "Mailbox rx channel, is not ready.\n");
> +		else
> +			dev_dbg(dev, "Failed to request rx channel\n");
> +
> +		goto exit;
> +	}
> +
> +	priv->dev = dev;
> +	priv->info = info;
> +
> +	/* Initialize the mutex. */
> +	mutex_init(&priv->se_if_lock);
> +	mutex_init(&priv->se_if_cmd_lock);
> +
> +	priv->cmd_receiver_dev = NULL;
> +	priv->waiting_rsp_dev = NULL;
> +	priv->max_dev_ctx = info->max_dev_ctx;
> +	priv->cmd_tag = info->cmd_tag;
> +	priv->rsp_tag = info->rsp_tag;
> +	priv->mem_pool_name = info->pool_name;
> +	priv->success_tag = info->success_tag;
> +	priv->base_api_ver = info->base_api_ver;
> +	priv->fw_api_ver = info->fw_api_ver;
> +
> +	init_completion(&priv->done);
> +	spin_lock_init(&priv->lock);
> +
> +	if (info->reserved_dma_ranges) {
> +		ret = of_reserved_mem_device_init(dev);
> +		if (ret) {
> +			dev_err(dev,
> +				"failed to init reserved memory region %d\n",
> +				ret);
> +			priv->flags &= (~RESERVED_DMA_POOL);
> +			goto exit;
> +		}
> +		priv->flags |= RESERVED_DMA_POOL;
> +	}
> +
> +	if (info->fw_name_in_rfs) {
> +		ret = request_firmware_nowait(THIS_MODULE,
> +					      FW_ACTION_UEVENT,
> +					      info->fw_name_in_rfs,
> +					      dev, GFP_KERNEL, priv,
> +					      se_load_firmware);
> +		if (ret)
> +			dev_warn(dev, "Failed to get firmware [%s].\n",
> +				 info->fw_name_in_rfs);
> +	}
> +
> +	ret = imx_fetch_soc_info(dev);
> +	if (ret) {
> +		dev_err(dev,
> +			"failed[%d] to fetch SoC Info\n", ret);
> +		goto exit;
> +	}
> +
> +	if (info->imem_mgmt) {
> +		/* allocate buffer where SE store encrypted IMEM */
> +		priv->imem.buf = dmam_alloc_coherent(dev, ELE_IMEM_SIZE,
> +						     &priv->imem.phyaddr,
> +						     GFP_KERNEL);
> +		if (!priv->imem.buf) {
> +			dev_err(dev,
> +				"dmam-alloc-failed: To store encr-IMEM.\n");
> +			ret = -ENOMEM;
> +			goto exit;
> +		}
> +	}
> +
> +	if (info->max_dev_ctx) {
> +		ret = init_device_context(dev);
> +		if (ret) {
> +			dev_err(dev,
> +				"Failed[0x%x] to create device contexts.\n",
> +				ret);
> +			goto exit;
> +		}
> +	}
> +
> +	dev_info(dev, "i.MX secure-enclave: %s interface to firmware, configured.\n",
> +		 info->se_name);
> +	return devm_of_platform_populate(dev);
> +
> +exit:
> +	/* if execution control reaches here, if probe fails.
> +	 * hence doing the cleanup
> +	 */
> +	if (se_probe_if_cleanup(pdev))
> +		dev_err(dev,
> +			"Failed to clean-up the child node probe.\n");
> +
> +	return ret;
> +}
> +
> +static int se_probe(struct platform_device *pdev)
> +{
> +	struct device_node *enum_dev_node;
> +	struct device *dev = &pdev->dev;
> +	int enum_count;
> +	int ret;
> +
> +	enum_count = of_get_child_count(dev->of_node);
> +	if (!enum_count) {
> +		ret = -EINVAL;
> +		dev_err(dev, "Zero Tx/Rx path MU nodes.\n");
> +		return ret;
> +	}
> +
> +	for_each_child_of_node(dev->of_node, enum_dev_node) {
> +		struct platform_device *enum_plat_dev __maybe_unused;
> +
> +		if (!of_device_is_available(enum_dev_node))
> +			continue;
> +
> +		enum_plat_dev = of_platform_device_create(enum_dev_node,
> +							  NULL,
> +							  dev);
> +		if (!enum_plat_dev) {
> +			ret = -EINVAL;
> +			of_node_put(enum_dev_node);
> +			dev_err(dev,
> +				"Failed to create enumerated platform device.");
> +			break;
> +		}
> +
> +		ret = se_if_probe(enum_plat_dev);
> +	}
> +	return ret;
> +}
> +
> +static int se_remove(struct platform_device *pdev)
> +{
> +	if (se_probe_cleanup(pdev))
> +		dev_err(&pdev->dev,
> +			"i.MX Secure Enclave is not cleanly un-probed.");
> +
> +	return 0;
> +}
> +
> +static int se_suspend(struct device *dev)
> +{
> +	struct se_if_priv *priv = dev_get_drvdata(dev);
> +	const struct imx_se_node_info *info
> +					= priv->info;
> +
> +	if (info && info->imem_mgmt)
> +		priv->imem.size = se_save_imem_state(dev);
> +
> +	return 0;
> +}
> +
> +static int se_resume(struct device *dev)
> +{
> +	struct se_if_priv *priv = dev_get_drvdata(dev);
> +	const struct imx_se_node_info *info
> +					= priv->info;
> +	int i;
> +
> +	for (i = 0; i < priv->max_dev_ctx; i++)
> +		wake_up_interruptible(&priv->ctxs[i]->wq);
> +
> +	if (info && info->imem_mgmt)
> +		se_restore_imem_state(dev);
> +
> +	return 0;
> +}
> +
> +static const struct dev_pm_ops se_pm = {
> +	RUNTIME_PM_OPS(se_suspend, se_resume, NULL)
> +};
> +
> +static struct platform_driver se_driver = {
> +	.driver = {
> +		.name = "fsl-se-fw",
> +		.of_match_table = se_match,
> +		.pm = &se_pm,
> +	},
> +	.probe = se_probe,
> +	.remove = se_remove,
> +};
> +MODULE_DEVICE_TABLE(of, se_match);
> +
> +module_platform_driver(se_driver);
> +
> +MODULE_AUTHOR("Pankaj Gupta <pankaj.gupta@nxp.com>");
> +MODULE_DESCRIPTION("iMX Secure Enclave Driver.");
> +MODULE_LICENSE("GPL");
> diff --git a/drivers/firmware/imx/se_ctrl.h b/drivers/firmware/imx/se_ctrl.h
> new file mode 100644
> index 000000000000..76e1ce77c52f
> --- /dev/null
> +++ b/drivers/firmware/imx/se_ctrl.h
> @@ -0,0 +1,151 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +/*
> + * Copyright 2024 NXP
> + */
> +
> +#ifndef SE_MU_H
> +#define SE_MU_H
> +
> +#include <linux/miscdevice.h>
> +#include <linux/semaphore.h>
> +#include <linux/mailbox_client.h>
> +
> +#define MAX_FW_LOAD_RETRIES		50
> +
> +#define MSG_TAG(x)			(((x) & 0xff000000) >> 24)
> +#define MSG_COMMAND(x)			(((x) & 0x00ff0000) >> 16)
> +#define MSG_SIZE(x)			(((x) & 0x0000ff00) >> 8)
> +#define MSG_VER(x)			((x) & 0x000000ff)
> +#define RES_STATUS(x)			((x) & 0x000000ff)
> +#define MAX_DATA_SIZE_PER_USER		(65 * 1024)
> +#define S4_DEFAULT_MUAP_INDEX		(2)
> +#define S4_MUAP_DEFAULT_MAX_USERS	(4)
> +#define MESSAGING_VERSION_6		0x6
> +#define MESSAGING_VERSION_7		0x7
> +
> +#define DEFAULT_MESSAGING_TAG_COMMAND           (0x17u)
> +#define DEFAULT_MESSAGING_TAG_RESPONSE          (0xe1u)
> +
> +#define SE_MU_IO_FLAGS_USE_SEC_MEM	(0x02u)
> +#define SE_MU_IO_FLAGS_USE_SHORT_ADDR	(0x04u)
> +
> +struct se_imem_buf {
> +	u8 *buf;
> +	phys_addr_t phyaddr;
> +	u32 size;
> +};
> +
> +struct se_buf_desc {
> +	u8 *shared_buf_ptr;
> +	u8 *usr_buf_ptr;
> +	u32 size;
> +	struct list_head link;
> +};
> +
> +/* Status of a char device */
> +enum se_if_dev_ctx_status_t {
> +	MU_FREE,
> +	MU_OPENED
> +};
> +
> +struct se_shared_mem {
> +	dma_addr_t dma_addr;
> +	u32 size;
> +	u32 pos;
> +	u8 *ptr;
> +};
> +
> +/* Private struct for each char device instance. */
> +struct se_if_device_ctx {
> +	struct device *dev;
> +	struct se_if_priv *priv;
> +	struct miscdevice miscdev;
> +
> +	enum se_if_dev_ctx_status_t status;
> +	wait_queue_head_t wq;
> +	struct semaphore fops_lock;
> +
> +	u32 pending_hdr;
> +	struct list_head pending_in;
> +	struct list_head pending_out;
> +
> +	struct se_shared_mem secure_mem;
> +	struct se_shared_mem non_secure_mem;
> +
> +	u32 *temp_resp;
> +	u32 temp_resp_size;
> +	struct notifier_block se_notify;
> +};
> +
> +/* Header of the messages exchange with the EdgeLock Enclave */
> +struct se_msg_hdr {
> +	u8 ver;
> +	u8 size;
> +	u8 command;
> +	u8 tag;
> +}  __packed;
> +
> +#define SE_MU_HDR_SZ	4
> +#define TAG_OFFSET	(SE_MU_HDR_SZ - 1)
> +#define CMD_OFFSET	(SE_MU_HDR_SZ - 2)
> +#define SZ_OFFSET	(SE_MU_HDR_SZ - 3)
> +#define VER_OFFSET	(SE_MU_HDR_SZ - 4)
> +
> +struct se_api_msg {
> +	u32 header; /* u8 Tag; u8 Command; u8 Size; u8 Ver; */
> +	u32 *data;
> +};
> +
> +struct se_if_priv {
> +	struct se_if_device_ctx *cmd_receiver_dev;
> +	struct se_if_device_ctx *waiting_rsp_dev;
> +	bool no_dev_ctx_used;
> +	/*
> +	 * prevent parallel access to the se interface registers
> +	 * e.g. a user trying to send a command while the other one is
> +	 * sending a response.
> +	 */
> +	struct mutex se_if_lock;
> +	/*
> +	 * prevent a command to be sent on the se interface while another one is
> +	 * still processing. (response to a command is allowed)
> +	 */
> +	struct mutex se_if_cmd_lock;
> +	struct device *dev;
> +	u8 *mem_pool_name;
> +	u8 cmd_tag;
> +	u8 rsp_tag;
> +	u8 success_tag;
> +	u8 base_api_ver;
> +	u8 fw_api_ver;
> +	u32 fw_fail;
> +	const void *info;
> +
> +	struct mbox_client se_mb_cl;
> +	struct mbox_chan *tx_chan, *rx_chan;
> +	struct se_api_msg *rx_msg;
> +	struct completion done;
> +	spinlock_t lock;
> +	/*
> +	 * Flag to retain the state of initialization done at
> +	 * the time of se-mu probe.
> +	 */
> +	uint32_t flags;
> +	u8 max_dev_ctx;
> +	struct se_if_device_ctx **ctxs;
> +	struct se_imem_buf imem;
> +};
> +
> +void *get_phy_buf_mem_pool(struct device *dev,
> +			   u8 *mem_pool_name,
> +			   dma_addr_t *buf,
> +			   u32 size);
> +phys_addr_t get_phy_buf_mem_pool1(struct device *dev,
> +				 u8 *mem_pool_name,
> +				 u32 **buf,
> +				 u32 size);
> +void free_phybuf_mem_pool(struct device *dev,
> +			  u8 *mem_pool_name,
> +			  u32 *buf,
> +			  u32 size);
> +#endif
> diff --git a/include/linux/firmware/imx/se_api.h b/include/linux/firmware/imx/se_api.h
> new file mode 100644
> index 000000000000..c47f84906837
> --- /dev/null
> +++ b/include/linux/firmware/imx/se_api.h
> @@ -0,0 +1,14 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +/*
> + * Copyright 2024 NXP
> + */
> +
> +#ifndef __SE_API_H__
> +#define __SE_API_H__
> +
> +#include <linux/types.h>
> +
> +#define SOC_ID_OF_IMX8ULP		0x084D
> +#define SOC_ID_OF_IMX93			0x9300
> +
> +#endif /* __SE_API_H__ */
> diff --git a/include/uapi/linux/se_ioctl.h b/include/uapi/linux/se_ioctl.h
> new file mode 100644
> index 000000000000..f68a36e9da2c
> --- /dev/null
> +++ b/include/uapi/linux/se_ioctl.h
> @@ -0,0 +1,88 @@
> +/* SPDX-License-Identifier: (GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause*/
> +/*
> + * Copyright 2024 NXP
> + */
> +
> +#ifndef SE_IOCTL_H
> +#define SE_IOCTL_H
> +
> +/* IOCTL definitions. */
> +
> +struct se_ioctl_setup_iobuf {
> +	u8 *user_buf;
> +	u32 length;
> +	u32 flags;
> +	u64 ele_addr;
> +};
> +
> +struct se_ioctl_shared_mem_cfg {
> +	u32 base_offset;
> +	u32 size;
> +};
> +
> +struct se_ioctl_get_if_info {
> +	u8 se_if_id;
> +	u8 interrupt_idx;
> +	u8 tz;
> +	u8 did;
> +	u8 cmd_tag;
> +	u8 rsp_tag;
> +	u8 success_tag;
> +	u8 base_api_ver;
> +	u8 fw_api_ver;
> +};
> +
> +struct se_ioctl_signed_message {
> +	u8 *message;
> +	u32 msg_size;
> +	u32 error_code;
> +};
> +
> +struct se_ioctl_get_soc_info {
> +	u16 soc_id;
> +	u16 soc_rev;
> +};
> +
> +/* IO Buffer Flags */
> +#define SE_IO_BUF_FLAGS_IS_OUTPUT	(0x00u)
> +#define SE_IO_BUF_FLAGS_IS_INPUT	(0x01u)
> +#define SE_IO_BUF_FLAGS_USE_SEC_MEM	(0x02u)
> +#define SE_IO_BUF_FLAGS_USE_SHORT_ADDR	(0x04u)
> +#define SE_IO_BUF_FLAGS_IS_IN_OUT	(0x10u)
> +
> +/* IOCTLS */
> +#define SE_IOCTL			0x0A /* like MISC_MAJOR. */
> +
> +/*
> + * ioctl to designated the current fd as logical-reciever.
> + * This is ioctl is send when the nvm-daemon, a slave to the
> + * firmware is started by the user.
> + */
> +#define SE_IOCTL_ENABLE_CMD_RCV	_IO(SE_IOCTL, 0x01)
> +
> +/*
> + * ioctl to get the buffer allocated from the memory, which is shared
> + * between kernel and FW.
> + * Post allocation, the kernel tagged the allocated memory with:
> + *  Output
> + *  Input
> + *  Input-Output
> + *  Short address
> + *  Secure-memory
> + */
> +#define SE_IOCTL_SETUP_IOBUF	_IOWR(SE_IOCTL, 0x03, \
> +					struct se_ioctl_setup_iobuf)
> +
> +/*
> + * ioctl to get the mu information, that is used to exchange message
> + * with FW, from user-spaced.
> + */
> +#define SE_IOCTL_GET_MU_INFO	_IOR(SE_IOCTL, 0x04, \
> +					struct se_ioctl_get_if_info)
> +/*
> + * ioctl to get SoC Info from user-space.
> + */
> +#define SE_IOCTL_GET_SOC_INFO      _IOR(SE_IOCTL, 0x06, \
> +					struct se_ioctl_get_soc_info)
> +
> +#endif
> 



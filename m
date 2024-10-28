Return-Path: <linux-kernel+bounces-384228-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B5F709B2891
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 08:15:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF6B61C21322
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 07:15:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 599DF19047C;
	Mon, 28 Oct 2024 07:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=de.bosch.com header.i=@de.bosch.com header.b="L0GnH0ML"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2047.outbound.protection.outlook.com [40.107.21.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 432C818FDC9;
	Mon, 28 Oct 2024 07:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730099648; cv=fail; b=m2Lv6hBGFIskTN1mhQuH4bHMaxf2xWaJ5bNsRqVFBAWRCWH1zP7NB+byB230b3aEbNYIc7JDtdZ6uXW6eFi8wD/CXa2R3PCuUzBCW2gTvA95nZS4qDHUWUAdPk6q1QJ+meE9xPduCEJJIR37XWk9vICGoiobJ1Im6vtzHhxXXUc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730099648; c=relaxed/simple;
	bh=UTMlQd70rL8sJrpYFGQa2dpGtD76CchPT/j/2QXUyLs=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=cl0SnHP6j+IJiE9PoAKmgbn5oh6Q6+aE/DLN0vIVV9kxro6FvjvX9nuTjj0P3UollgyLS5HVpvBWc4TqCVboNrG2A4EwPG7B7m06AFqstWFOa5uZgo7aEl4NDKIuqMrV7pddhe7IxGWMYI5wCV7M6hhfAqrWi2v1JH4LCm7CjNI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=de.bosch.com; spf=pass smtp.mailfrom=de.bosch.com; dkim=pass (2048-bit key) header.d=de.bosch.com header.i=@de.bosch.com header.b=L0GnH0ML; arc=fail smtp.client-ip=40.107.21.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=de.bosch.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=de.bosch.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ahJJhxjZJK6JlS2HHnWDAg/yxFT1zQ4ARAGIQlvljt27AYppYvhB7xGCr+V3VLEjA0VpTEos2v5EkwxPwHFfhOTuOmAU8u21+ZUdpu3hkEF+loIsk7Xtp80ogR2snCBvL7jAz6jI92R/gqUyliR/2okO8bEMiwGbrh3rZ2QWLTyAn4FuzCSxfQENzZze70zkm5oJkpycsHSFSnksk5+7kD8wkw8Gmap68MYmUAFF+jgv2JkQ1L4zlkdMkUXo2tVEqGfLP2T/J60hxQXitsytr1nQNwHPh6X2NUC90Svkzv0/CVnA1cSEI06g8TrUUaI45F5JcNHSzshDoSeQgXC/IA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7FojZdcnGbxzdX1VcCQpYXmOjNKrnWJOvUXRq8Xp4HM=;
 b=m7H1NhjJS8WYKBOydYTFzQCtMX3qFuqML1MZ2vI8CpnVKDu+iQVMCgbeTuhOJDhTXOi4so7ELeV+dZ9PvMx89xsJDeICOtzS4GWjEdyIdJ23Xn91Pi88680PrZ9wQmwXrZPbaLZ9vbD87auL2skNQfe84Te5VNi2KKmM7jehp+GBhtLXiQmAmZibZ90TYWRjx0tfD/LDW2Mcb69jKtiC/BVzvZ9en7csDqxjQAzrJKqwQ57voqZQUek+arT1Ii1WTxpt0825FpKybRwYcPNMEFWP4REqqeMXy8M//U1ncLVmEmRCJsVrdF6HyLo3uzfVtqHJEViBHFH7TetThNha0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 139.15.153.205) smtp.rcpttodomain=kernel.org smtp.mailfrom=de.bosch.com;
 dmarc=pass (p=reject sp=none pct=100) action=none header.from=de.bosch.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=de.bosch.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7FojZdcnGbxzdX1VcCQpYXmOjNKrnWJOvUXRq8Xp4HM=;
 b=L0GnH0MLYdmP7j0zJUL6+8dK7cmoP8B0/vblnJ0hT8dugLeptago7IpMutPINrkP70mAxZqshFqBB/6eVKNT67IGBb5r1mhBzG6e8N47/jGXsezb4Sfi/oPIqIolH4rFjUCNIC8fELirxPZlzoeHaXS7ZkUDzHBU8y/SRgQC8xPWst8JgfyVDIsuXYu3TV1Yc8SyiLWG5vQDNIWHzDjL6A/cPWBzmg8LleZyGmX8AcotZUAZ1N9mVDCzrL2QFqIdAR9dhUGtmZ0HjwPb/+Os/CKJEtgciENc/lwdp3GtwLbgbmxhJLT4PYX6NGBO7+LZuDPrguaasZjJTDTrw7Y9JA==
Received: from AS9PR07CA0003.eurprd07.prod.outlook.com (2603:10a6:20b:46c::16)
 by VI0PR10MB8883.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:213::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.11; Mon, 28 Oct
 2024 07:14:01 +0000
Received: from AMS1EPF00000046.eurprd04.prod.outlook.com
 (2603:10a6:20b:46c:cafe::cc) by AS9PR07CA0003.outlook.office365.com
 (2603:10a6:20b:46c::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.11 via Frontend
 Transport; Mon, 28 Oct 2024 07:14:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 139.15.153.205)
 smtp.mailfrom=de.bosch.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=de.bosch.com;
Received-SPF: Pass (protection.outlook.com: domain of de.bosch.com designates
 139.15.153.205 as permitted sender) receiver=protection.outlook.com;
 client-ip=139.15.153.205; helo=eop.bosch-org.com; pr=C
Received: from eop.bosch-org.com (139.15.153.205) by
 AMS1EPF00000046.mail.protection.outlook.com (10.167.16.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8114.16 via Frontend Transport; Mon, 28 Oct 2024 07:14:01 +0000
Received: from SI-EXCAS2001.de.bosch.com (10.139.217.202) by eop.bosch-org.com
 (139.15.153.205) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 28 Oct
 2024 08:14:00 +0100
Received: from [10.34.219.93] (10.139.217.196) by SI-EXCAS2001.de.bosch.com
 (10.139.217.202) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 28 Oct
 2024 08:13:59 +0100
Message-ID: <df1473dc-99a4-4a6c-bfc3-09c37b9883d5@de.bosch.com>
Date: Mon, 28 Oct 2024 08:13:59 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 3/3] samples: rust: platform: Add property read
 examples
To: "Rob Herring (Arm)" <robh@kernel.org>, Saravana Kannan
	<saravanak@google.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>, Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, "Gary
 Guo" <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?=
	<bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, "Trevor
 Gross" <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, Dirk Behme
	<dirk.behme@gmail.com>
CC: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<rust-for-linux@vger.kernel.org>
References: <20241025-rust-platform-dev-v1-0-0df8dcf7c20b@kernel.org>
 <20241025-rust-platform-dev-v1-3-0df8dcf7c20b@kernel.org>
Content-Language: en-US
From: Dirk Behme <dirk.behme@de.bosch.com>
In-Reply-To: <20241025-rust-platform-dev-v1-3-0df8dcf7c20b@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS1EPF00000046:EE_|VI0PR10MB8883:EE_
X-MS-Office365-Filtering-Correlation-Id: 8191b658-ae1d-4a59-f739-08dcf720193a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|36860700013|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cmg0cmNlNk1LNFBjRk50bm00OXp0c0VBR1h2ZkcwQnBGc3JrRkJveGs2QmFa?=
 =?utf-8?B?R0JJaFkvcmZ6RTlnRUNKUHNpKzlnZVk3cTBCK3FackpWQnFBOEI3WGpHUUor?=
 =?utf-8?B?RW0wTWhhUmhOTlNkbFQ4MmI2UTY2N0JybUtCa1VsVE9UNTdxRHFrajJ2cGpU?=
 =?utf-8?B?elZRSERWYzFNOHZEKzczVnJRbGRxSXZrQ3F6NURXdEw5VCtrejdYdngwSVJt?=
 =?utf-8?B?N01mSFFHQ09zWXdjUjBEajF4aHRNL1Yzemd1R2VHTDlJUHUzWTA2d3NKQ0pM?=
 =?utf-8?B?SjhIdmJRbDRUVXRieGRnNEV4TkpZc0E3dDFDWk9wbm1qWkU1eDdsbzNpOXVh?=
 =?utf-8?B?VGxVM0t6Z0ErUHg0Q00yWG1OSHZvZXhTb1pOMTBFVFBpQWdlRXBTbjl3K1hG?=
 =?utf-8?B?UHZBMHg0eXRrTEgxUWlPeSttdlEveWEwUTQxOGxhSTV2Nll3SFBhWWlZa3RE?=
 =?utf-8?B?dFFTM2tvVEQ4RUZ5UGRvUmltNHV1Tk94VjFHMFlOUTA1SDUzbmcwNk03WGd2?=
 =?utf-8?B?RzFXbTN1UUFQTWV2WGY3b3Q0dktpSmt3U2lQK29vRkViaXplQ1pJMGNoU1FW?=
 =?utf-8?B?amlpTlV4dnB2YUV5ZHg2VThJSmhEelBpUEZaWXRKOTlYTldYTG1Ga1pROXVv?=
 =?utf-8?B?N3gyUUhYZExpN2dwR2dOMXhxSW93UGRGL3l0TkZOc2JmWktJY25maGVxNVQ0?=
 =?utf-8?B?UmgyWUVvTVU0ZU53ZHJHaG9PMWt6V0orbU1FemY1VGlTWVk1YWRSQ2pqRUxh?=
 =?utf-8?B?OWRYZU04c0RPak1IYTI3YzlTWCtTbmtVT09ObHRUNHRjUmRSdTVCLzBTNkFD?=
 =?utf-8?B?a2ZIdnNETlluQ3JKKzh0eUprWkVoUGllRGVQN2FOb09vUDBEVUhSR3pTTUV0?=
 =?utf-8?B?Z21TbjVaYmRSemY3OHhLb2ZWMS9OQ2FhYkVBeWZmMG9TRXV3MUVWVmRHV0o3?=
 =?utf-8?B?L3h6dkFFMTJwaTViTnFiY3pGVlM4akJ4TkpqWHRpMS9hVlQrTVZGUGUzY0tu?=
 =?utf-8?B?cXVpUDdYMmEzcTNpcmNxMVZ2ck1vVWtkREJXOEdSRVc5RytDVjhXUkFZQjln?=
 =?utf-8?B?YWR6L2ZGb2hSQlhDc2ZoMWVJNi9oZWFDeW43OVN0YUduR3NKdkFJMVEveDZD?=
 =?utf-8?B?Zk96OGRSa3JsY3RieDd1V01EaEI5eDlRd1F2S0h2bkVsRnRmUFc3Q3JicEZj?=
 =?utf-8?B?R0c2dlBhbUJCOTJFeHIyMXVqL0E3RFNGZG1IMXA5R0Q5cjNJMzB5SDlQTTU4?=
 =?utf-8?B?L3pYeVpJYkdWTW1zVG5XZXNWWmRULzdLZnp5b2tDMjV3TUl0WkRMRkl2UXdn?=
 =?utf-8?B?Zm8vUXVkWXhDRWZuTENkeWFWS29LNlVvQXNtdmhTUDJjNVhNQjJ0c2FlRGsr?=
 =?utf-8?B?VE5VcmFzV3llcjkrZDZPUHgrL2hKWm85MmFLY0ZyMzJOSDNuN0RydUx4N2Rl?=
 =?utf-8?B?dW9MM09LbklFTlFyOXFmdFJITEZBRUt3cVFLL0xXVXBPaXBmYUUzMmY2QWR6?=
 =?utf-8?B?VVRxdkw1a3UwL1RjaysvMmFMZFhHbFZ5YXByOFNrQzVvYjFyZm5YQVU2UVJZ?=
 =?utf-8?B?dXZDbCtZd0liTEEwd0dWU09tdkRhQ2IyK3Zjd21zVlErYm5iN21WQW5YTGgw?=
 =?utf-8?B?RmtPVkx6U3M5V056bXZ2aUllL0VNMG5uVFo0L3Y3aEFxdmdqamlzczdtQzF2?=
 =?utf-8?B?OTgyNStlSmdDMnQxUXFSL0xPWXl0cTcxZ0F0OGxhODFDOURJa3Z2MnY2VzVu?=
 =?utf-8?B?K3JFalQrZ3B5cEVQR2pDR001M3h1RktjZEdtR2prZzRqbWx4djMrVm9YcXBh?=
 =?utf-8?B?SHN6UEJ3Nm5PM3pYMWY1R0lTa05rYjNSQ01JTDM1QzNxSXlZWjN1UTRaaGtV?=
 =?utf-8?B?NTkvMFlDK1YvbjlYVmtzYTFTdXcxdkxmY3d1aDFXMTIzTWREU2gzZmo4RlRl?=
 =?utf-8?Q?oCjw53jSV0M=3D?=
X-Forefront-Antispam-Report:
	CIP:139.15.153.205;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:eop.bosch-org.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(36860700013)(1800799024)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: de.bosch.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2024 07:14:01.3451
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8191b658-ae1d-4a59-f739-08dcf720193a
X-MS-Exchange-CrossTenant-Id: 0ae51e19-07c8-4e4b-bb6d-648ee58410f4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0ae51e19-07c8-4e4b-bb6d-648ee58410f4;Ip=[139.15.153.205];Helo=[eop.bosch-org.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS1EPF00000046.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR10MB8883

On 25.10.2024 23:05, Rob Herring (Arm) wrote:
> Add some example usage of the device property read methods for
> DT/ACPI/swnode properties.
> 
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>


I think that we should mention that this works only with 
CONFIG_OF_UNITTEST enabled? And/or maybe wrap the whole somehow with

#[cfg(CONFIG_OF_UNITTEST)]

?

> ---
>   drivers/of/unittest-data/tests-platform.dtsi |  3 +++
>   samples/rust/rust_driver_platform.rs         | 22 ++++++++++++++++++++++
>   2 files changed, 25 insertions(+)
> 
> diff --git a/drivers/of/unittest-data/tests-platform.dtsi b/drivers/of/unittest-data/tests-platform.dtsi
> index 2caaf1c10ee6..a5369b9343b8 100644
> --- a/drivers/of/unittest-data/tests-platform.dtsi
> +++ b/drivers/of/unittest-data/tests-platform.dtsi
> @@ -37,6 +37,9 @@ dev@100 {
>   			test-device@2 {
>   				compatible = "test,rust-device";
>   				reg = <0x2>;
> +
> +				test,u32-prop = <0xdeadbeef>;
> +				test,i16-array = /bits/ 16 <1 2 (-3) (-4)>;
>   			};
>   		};
>   	};
> diff --git a/samples/rust/rust_driver_platform.rs b/samples/rust/rust_driver_platform.rs
> index 5cf4a8f86c13..95c290806862 100644
> --- a/samples/rust/rust_driver_platform.rs
> +++ b/samples/rust/rust_driver_platform.rs
> @@ -41,6 +41,28 @@ fn probe(pdev: &mut platform::Device, info: Option<&Self::IdInfo>) -> Result<Pin
>               }
>           };
>   
> +        let dev = pdev.as_ref();


Maybe move this up and use it in Danilo's part, as well? To stay consistent?

--- a/samples/rust/rust_driver_platform.rs
+++ b/samples/rust/rust_driver_platform.rs
@@ -26,25 +26,25 @@ impl platform::Driver for SampleDriver {

      fn probe(pdev: &mut platform::Device, info: Option<&Self::IdInfo>) 
-> Result<Pin<KBox<Self>>> {
          dev_dbg!(pdev.as_ref(), "Probe Rust Platform driver sample.\n");
+        let dev = pdev.as_ref();

          match (Self::of_match_device(pdev), info) {
              (Some(id), Some(info)) => {
                  dev_info!(
-                    pdev.as_ref(),
+                    dev,
                      "Probed by OF compatible match: '{}' with info: 
'{}'.\n",
                      id.compatible(),
                      info.0
                  );
              }
              _ => {
-                dev_info!(pdev.as_ref(), "Probed by name.\n");
+                dev_info!(dev, "Probed by name.\n");
              }
          };

-        let dev = pdev.as_ref();
          if let Ok(idx) = 
dev.property_match_string(c_str!("compatible"), c_str!("test,rust-device"))
          {
-            dev_info!(pdev.as_ref(), "matched compatible string idx = 
{}\n", idx);
+            dev_info!(dev, "matched compatible string idx = {}\n", idx);
          }

          let prop = dev.property_read_bool(c_str!("test,bool-prop"));
@@ -56,12 +56,10 @@ fn probe(pdev: &mut platform::Device, info: 
Option<&Self::IdInfo>) -> Result<Pin


> +        if let Ok(idx) = dev.property_match_string(c_str!("compatible"), c_str!("test,rust-device"))
> +        {
> +            dev_info!(pdev.as_ref(), "matched compatible string idx = {}\n", idx);
> +        }
> +
> +        let prop = dev.property_read_bool(c_str!("test,bool-prop"));

I stopped reading here with "hey, "test,bool-prop" isn't in the 
tests-platform.dtsi above, no?". Until I realized that this is 
intentional to get back false. So whats about adding a comment like

// Intentionally check for an non-existent property to get back false

?


> +        dev_info!(dev, "bool prop is {}\n", prop);
> +
> +        let _prop = dev.property_read::<u32>(c_str!("test,u32-prop"))?;
> +        let prop: u32 = dev.property_read(c_str!("test,u32-prop"))?;
> +        dev_info!(dev, "'test,u32-prop' is {:#x}\n", prop);
> +
> +        let prop: [i16; 4] = dev.property_read_array(c_str!("test,i16-array"))?;
> +        dev_info!(dev, "'test,i16-array' is {:?}\n", prop);
> +        dev_info!(
> +            dev,
> +            "'test,i16-array' length is {}\n",
> +            dev.property_count_elem::<u16>(c_str!("test,i16-array"))
> +                .unwrap()


In the error case unwrap() (or expect()) will result in panic(). Besides 
some very rare cases I don't see a reason why device drivers should 
panic. Esp. not if reading some array length from the device tree fails 
;) So I don't think we should encourage using unwrap() or expect() in 
drivers by using them even in example code. Which most probably will be 
copied quite often, then ;)

What's about anything like this instead?

          let prop: [i16; 4] = 
dev.property_read_array(c_str!("test,i16-array"))?;
          dev_info!(dev, "'test,i16-array' is {:?}\n", prop);
-        dev_info!(
-            dev,
-            "'test,i16-array' length is {}\n",
-            dev.property_count_elem::<u16>(c_str!("test,i16-array"))
-                .unwrap()
-        );
+        let len = dev.property_count_elem::<u16>(c_str!("test,i16-array"));
+        if let Ok(length) = len {
+            dev_info!(dev, "'test,i16-array' length is {}\n", length);
+        }

          let drvdata = KBox::new(Self { pdev: pdev.clone() }, GFP_KERNEL)?;

Or if we want a reasonable error message in the error case, as well, we 
could switch to a match, instead.

Best regards

Dirk



> +        );
> +
>           let drvdata = KBox::new(Self { pdev: pdev.clone() }, GFP_KERNEL)?;
>   
>           Ok(drvdata.into())
> 



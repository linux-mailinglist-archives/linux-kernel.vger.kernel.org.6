Return-Path: <linux-kernel+bounces-438992-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5697B9EA93D
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 08:06:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D1BD11882645
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 07:06:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03FB622CBCD;
	Tue, 10 Dec 2024 07:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ccgni6Oa"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2068.outbound.protection.outlook.com [40.107.94.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B56622839A
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 07:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733814364; cv=fail; b=RpfWLsbdr72cBulmCC05Cwq63tQRizlzrM7bmri3vE91bJnIK/YMwhRF+dtgAZPndmWsygIOxo8qfF/VuUeLVUgN3L4r4Gr7EzM1ryFklT8om1UQXiSF03DDCjvLrkzWTrPAs7BBsVc/BvvpD5AT2fyzyQxQHcL8z7cvlntdBj4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733814364; c=relaxed/simple;
	bh=LUS2SV9Ol2wd/LcgjSibt3VnQ+WIT3JGBjn58+18Mtk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dNlBulORRDokHOEXFPI/SUvW1PNdps2JQ9Exf3yULcAz71mmonraHZlQ4wCV1iLpwwtEVItX41sayE2H6SL1trtFJ+doi2AamYcFiOFMjZdXUM7MWFIq7ZmuNETvGEyMIa6bVpZNy+zOJXY+L14pqNWSsV37g/JMy5qRgWG6TXU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ccgni6Oa; arc=fail smtp.client-ip=40.107.94.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v+Z3sdcWmtLt0tuznNfTfQEKtwRK52Z8H5Th6aNGNq9Ni3BLFgjuwVwD4kLgMO85GtSCPYMWuoATeSJOQykQYLJhjHN37EEA90xpvw+U4DZ+xSjooxAHuoBPYFgRpqk5f5c5To2CZXwPHKtMn+/1N+pmwGyT4ljKdqo5R/tdWVZgxNVXdERv5sRmHq+Ej0Z6t7Hnl9hSSkUyn+TgbOmc9761OL5RAA3rERzWhw6ErSZUgdZ7+ml9HlbEGJG5FcVn9fQiugZkze9jx/Ru2ObDQdnuYB7m7pfKSD1T8UD2vTeuouuujd3xm2I3V7TVaNM70caZNdl4rCPxhj+gQ6f5WQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LUS2SV9Ol2wd/LcgjSibt3VnQ+WIT3JGBjn58+18Mtk=;
 b=Hfsyf84OVzYLJ0O6hFok4/FbVXSosTK6oTMX7DwMlL3PBoWrVTXP9sR6+F86jt80/zNfJQjxlLikTIX2/oQ96X3nnR3L1Imv5leyjTghnS5uhxfxyuz+b/JhSq0SaEA1XcbzmmvgNtrlQScjeSVfjZwyE4oTTtnNi2RNmuU4EVoKWPKMjbRpE23NgUg+0NyAhj5JrjmJgrcgSxyAIqK2zOGff5RidSXBAqhQXHkoqqLwmxX3TvO1ryuJporHz26ai+1Z1+9RV8XqTRiQs11XpKjhUStJKPSY0jBW8bTvbvgB4bkjuhou31oxsgtzR5WW8hcb/S3vOikJrNRtwUIaCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LUS2SV9Ol2wd/LcgjSibt3VnQ+WIT3JGBjn58+18Mtk=;
 b=ccgni6Oa56EvXwI695n7n6UO9N2y5DIar0FrG1pz581+Ish5Lkf/km/mUNZC6aQC5RgD6cNPiIzquvFxlJxjoiEBlwkNa0Whud+FihUPq6Yt0rxKnxgNgyIluQrBmADjiOjEq9KKMXNstYWlgD/fxPuJdJAfV53L55iubaSnhe0=
Received: from BL1PR12MB5333.namprd12.prod.outlook.com (2603:10b6:208:31f::11)
 by CH3PR12MB9395.namprd12.prod.outlook.com (2603:10b6:610:1ce::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.17; Tue, 10 Dec
 2024 07:05:55 +0000
Received: from BL1PR12MB5333.namprd12.prod.outlook.com
 ([fe80::d4a:9dd1:afd9:1c70]) by BL1PR12MB5333.namprd12.prod.outlook.com
 ([fe80::d4a:9dd1:afd9:1c70%4]) with mapi id 15.20.8251.008; Tue, 10 Dec 2024
 07:05:55 +0000
From: "Agarwal, Nikhil" <nikhil.agarwal@amd.com>
To: "Gangurde, Abhijit" <abhijit.gangurde@amd.com>, "Gupta, Nipun"
	<Nipun.Gupta@amd.com>
CC: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Simek,
 Michal" <michal.simek@amd.com>, "git (AMD-Xilinx)" <git@amd.com>, "Gangurde,
 Abhijit" <abhijit.gangurde@amd.com>
Subject: RE: [PATCH v2 1/2] cdx: register shutdown callback for cdx controller
Thread-Topic: [PATCH v2 1/2] cdx: register shutdown callback for cdx
 controller
Thread-Index: AQHbRV/JHoY+1CpCbE6TgKk++IKvi7LfGCcw
Date: Tue, 10 Dec 2024 07:05:55 +0000
Message-ID:
 <BL1PR12MB53331D320D70A12414E7325D9D3D2@BL1PR12MB5333.namprd12.prod.outlook.com>
References: <20241203084409.2747897-1-abhijit.gangurde@amd.com>
In-Reply-To: <20241203084409.2747897-1-abhijit.gangurde@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_94523dde-f9d1-4aa7-80a9-c0900420d3c3_ActionId=4c8a831b-77fe-40cf-9d07-a77e40900fbc;MSIP_Label_94523dde-f9d1-4aa7-80a9-c0900420d3c3_ContentBits=0;MSIP_Label_94523dde-f9d1-4aa7-80a9-c0900420d3c3_Enabled=true;MSIP_Label_94523dde-f9d1-4aa7-80a9-c0900420d3c3_Method=Privileged;MSIP_Label_94523dde-f9d1-4aa7-80a9-c0900420d3c3_Name=Non-Business_New;MSIP_Label_94523dde-f9d1-4aa7-80a9-c0900420d3c3_SetDate=2024-12-10T07:02:30Z;MSIP_Label_94523dde-f9d1-4aa7-80a9-c0900420d3c3_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5333:EE_|CH3PR12MB9395:EE_
x-ms-office365-filtering-correlation-id: 8d58b8ef-8329-40d8-f0bb-08dd18e9175e
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?J3p9Y0BQwPREUC/0LWddgYLk7cgVUlNOif7/ZcnP4Nv42nhEnf1g3YddmT5r?=
 =?us-ascii?Q?0T9ytXuV6x6W9g6VKMLDkJazICjWEgHaaZ3dE2fevFmb3iieFqtr5gDr4+A5?=
 =?us-ascii?Q?KUIyKronPEwoUYRnNkW5XrdJSCNE7P0LfAvuIuN6iZV+01TVMyvKWS41C9Xv?=
 =?us-ascii?Q?4EVkmfxFtH9KP/jjr7dMLKc45TE9gWsXGJfS2dUQxNJI9iLcgXbSjHJnrylw?=
 =?us-ascii?Q?qDm1NhqYBLwaZGaHHlPDCHJ64U30sJ9FLhGnpMgKDbKFhIQg9CMMgYxZY2pV?=
 =?us-ascii?Q?ujAqAxeZbUfJ8quWIc4Ho7qXO3XOJhgnbOyAOb9clYRATqeoLRngg3TNhtFm?=
 =?us-ascii?Q?F9GZnwQ1YQY7nDpopLmSXmR9w6HsrJYo6lpkcRHqeVVoREwHAn9+GwGVnXx4?=
 =?us-ascii?Q?meYVHfFY78UWRMZrxVy2SaBq6TQFaBQ0pxL6jhi9DEv+Dqbq2xBouDTo9nfJ?=
 =?us-ascii?Q?qGLZHgDvZ2iPwK9L0JixboFLIZc5MXfFaMhygXCMf4gptOjXDRcmaws+TDaR?=
 =?us-ascii?Q?kQvDYVOCHBVqDCxdNLeAPiPSVtm07GER1UkFQdV6s5GMP5KED1+qyla5yURJ?=
 =?us-ascii?Q?PtcAAbd1awWm+fdO2ZL8/ADV9T40Y5hjw7l/JmxRWf+12aM4XaWU2nIXDGBC?=
 =?us-ascii?Q?zQtTJKDW1q7b/aD7pKwTwUcVpQ9fPhd5w2DLCVSY7IS6whM2txh+91xhKptE?=
 =?us-ascii?Q?0acAQWnKN8XikuZxZWhwoxykNfWNtMWizDJLwDGyJjBGUW8OMDOwMFyLyXKa?=
 =?us-ascii?Q?nuwpoG04uv2S6xg3Zkjiecm9PGUCnuO7cUligUPj13KJVtoGuVX78/rY/ZCb?=
 =?us-ascii?Q?aO1PJNKE1NRQvkkIJNL0rlNzYv5iTno1Bfr5j6DpETd7IOF4mXTIsTPyKfJ2?=
 =?us-ascii?Q?4BF2/h3OZos6Jjm31DXEaYj9+a+1xXyXDsxRs5CcO8IyeMwwhsjrysrSfb0U?=
 =?us-ascii?Q?sDOmo23QpxxOV3rhShu6tvgiVu2k1eYMvRyAuUM/5M38i5f6gNizvawBrAoa?=
 =?us-ascii?Q?OdiVViYl93SEqD67VYj3sQwEorpksP7yJ3fM8orgha9FGWViiloVscr8Bwaz?=
 =?us-ascii?Q?/GJCqXr5mgIlXQDJaw+oPja/YNx8e5ii8xUbhtC2Fd1pdt40tabDa39LfWiA?=
 =?us-ascii?Q?Qki7d4wAlmS2yNt77PtW0FImmJrCzmvy793+ybasqabZNZAnYPhdyyHRSy0V?=
 =?us-ascii?Q?H2N8HNqS6roP16l5XgeSOdrtluaVf5eTuNPTs8szIo+8wbYoMSHGuR6dEFwU?=
 =?us-ascii?Q?2RJGjizHeyNtmskH7PtaZ4Da690ZZ5jFboZEqVq2jsyusEM2U//XJm7O1Ww3?=
 =?us-ascii?Q?fBCCoLz40JGMoTD1Re+yebjWyVUOCWNHqIXlGkbEfwVR2AsRkMHh5cNR9mHs?=
 =?us-ascii?Q?Gh2HXJ6YEVzEXHqt0Svr5sdIUA6CaDmAIeDNObakHJNbPwDWEQ=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5333.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?ndDU+Zd0OlBYSmbQ07kRUxqX7+aweNupbhITCSQrXmO4tQyegS9NdTRoFyb+?=
 =?us-ascii?Q?VbK/OuqZkRv8JJoCIOkhXqFhX69V2Q5UlH6CjkAm5FX1bRr+5cxR9neacrCO?=
 =?us-ascii?Q?YlsgEtaf5OwSwFFI+8tnmiUzG2AVbM9zM3TDDn6d1YPVKrHqQtmyJzazvtV+?=
 =?us-ascii?Q?vGipI5DkglvlTL4sz97bgd3JRGRO5WvHNZBNUIkANgl2sRz2pSDM3KWDdINc?=
 =?us-ascii?Q?s8z/ESDPNIoRVA+QMZ+dYRh1wCXzxdfr6Op6J2KkSc21SED3hkha82pNfr5w?=
 =?us-ascii?Q?o1aqIgNjCoTWBuI7wk46NR3M9h83lGvv4kR3KvkRsZXLPs+I7mrwSm1Cx24M?=
 =?us-ascii?Q?971nGZECpadBLYSyYCEIfSi02qtiMQkLTXypPAvBgsmRzm6Vg5dDfA91UUbH?=
 =?us-ascii?Q?oA8M8nHOvV5cNst8JYZfU2EKjc/ZIbpU8allgsH2xRA66mP4JZ9CbVVMMgvx?=
 =?us-ascii?Q?o27duMajg8d+quomua/e+nkFVLNHQSUtUNdWVqN6Wi9GtoCycLpziZjUUqTq?=
 =?us-ascii?Q?ELL4Ds/BFTyBqT42Pn0NRUDIsrpK2d3rEW7arxVjFZPY0wKPjenD6ACFeK5O?=
 =?us-ascii?Q?A3WRcwAncM3GqTULcW+JRimHyip7l0QGc1BPv1joFvZOL9nhJIyOnCV1DDLI?=
 =?us-ascii?Q?i3fhnM1SfvasHUY9pSEvBlcje1s4O/aXQJ15m8Ha6kt88WZH5jYWjGHwEG/d?=
 =?us-ascii?Q?QCZfMM1QRb9ZUxoMpuTgzsiuTAa4DjaBjyQ7U7edCRmEAy9XAUh3bDGUw1Ka?=
 =?us-ascii?Q?1lRJ2nq0nDM3vaafyyJxUcQQKNTcyVAdYbri+XthFKx32taJxPE61IXhT/sn?=
 =?us-ascii?Q?+gsq8xNrrVZN4iyJhZDoDssq3DcNwlKuwAs7mRSKscjuAAkCUF49DmC5iQ5N?=
 =?us-ascii?Q?GbvhOzYNj8Nygz7ADMsilHQ1I1OQWY8lQZ7rjX6B0Pp0qaqNnljeCYrVbQhS?=
 =?us-ascii?Q?izV3Yj573Dbt9fftYjKMRnaL1nkp/ireiEzKF9yTeUuBpRLd5R1xnVDXth0S?=
 =?us-ascii?Q?U9lG36BR5KoyNfgjWrkqpu7WA5omOzsZMYh+VYDDXDRqYtxFnBwC543jmQ2x?=
 =?us-ascii?Q?NP8pX2DNBYLVffQhh3stwle7Nsk/gGVvonKSZEqQctToXfciHgTtp7XL7QkF?=
 =?us-ascii?Q?uwSB4LqdjiYIA4AsHB3G+Uc2y/4BkoIjpBw3krJDHRgIxVsAUWMqHQDkOJtD?=
 =?us-ascii?Q?k9m7pqBTWlzt9wTdOyba6cqLSOoBLtiDstg2tX/ngX7FWdbIkuq1t3mf+FRI?=
 =?us-ascii?Q?gkoQOsE1yq94hlCRybI4jHrZsXCb6sZb06W3wAlKMspJv+0kOsswTo2CZRTD?=
 =?us-ascii?Q?Mysg8v+aH7Ns1LBUpvwtn2P88X1gvmVxZfe3DMar2x+Z/f+UAIUaD0Gdcm9d?=
 =?us-ascii?Q?9jM2LdfuKjTuT6qPp1YHjmCy+GYmSptiw7oJbjvCpZdIgdua7EN6lCvAiGkQ?=
 =?us-ascii?Q?xJXCDQOTDV4EzSDOagrzHCta4t+ifeFssdL03eKNCslqOO60nCrJWoLbCoiO?=
 =?us-ascii?Q?1ltfGtGXcvJl10Ut7ec/PJTaIdZJ55wTTeU6W/tshqxXGfx54NNlb+4xWuqW?=
 =?us-ascii?Q?lEyYI86w4ieuuwtg8RY=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5333.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d58b8ef-8329-40d8-f0bb-08dd18e9175e
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Dec 2024 07:05:55.4926
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gQBxn9yge3oj8852ziOKAXtwKJ14VcjKieNZ88sWbq7PBm6BcnVsS6oaQh0XwRxA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9395



> -----Original Message-----
> From: Abhijit Gangurde <abhijit.gangurde@amd.com>
>=20
> register shutdown callback for cdx controller platform device to handle g=
raceful
> connection closure of rpmsg transport.
>=20
> Signed-off-by: Abhijit Gangurde <abhijit.gangurde@amd.com>

For the series,
Reviewed-by: Nikhil Agarwal <Nikhil.agarwal@amd.com>


Return-Path: <linux-kernel+bounces-394323-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 71B319BAD67
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 08:46:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 02BBF1F21BB8
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 07:46:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0061819069B;
	Mon,  4 Nov 2024 07:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b="PUrBDL0c"
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sg2apc01on2104.outbound.protection.outlook.com [40.107.215.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD35E16190C;
	Mon,  4 Nov 2024 07:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.104
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730706369; cv=fail; b=nFcHatg9vvORa8waExwty8zztwGKQV4mXWm9/X7jQN0j82siHJWAXh5tiayM2lcGv0d2n+tmObkHIde1UnBE1oRjlIlBuWGT37fmp+iIZB1K14y1aO9qpfVrmHUrlpqd5mbH75VBa8aOmFaGdozW7eXnBGSR0nkfdzUQ9Je++u0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730706369; c=relaxed/simple;
	bh=GNjuAJ74A8VMycErojw5HWz2XoZE/R+/gK6NILnA5Zs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Sjoa/ER9AkOeaBoVSfnPTunQx/CN6PXiwESU76dGAsWBYJCDRfEwZ+Z4DlLb/70X46hqlrDR0u+n2mas1pzwwDJdp3oz6V5h1YN93O7Bng9XTB0DsVv4GZgmjBvrIUYud0q+wxD1WolzN1DGCz1IsI7IFBOYXtdkQd6AOlfc27E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b=PUrBDL0c; arc=fail smtp.client-ip=40.107.215.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L41t2G8tY2xKidJ+uhVAR0AwXYanOcWCGgoMnIStmeq0uMQltzItHRnk5TATH+KuAgXKU6yrcLydZBbc1pLDcYf0Z5Vf8T0govlH+GbgiAEJFYNyn0ZQ9vwwZ8+vYjw4dqlN92dcVFlQyhYQjFiDBlKzLyxRbMxYPg8tDI5HxHW6B1MDEWsOgkMjK3ttzBYD5AqhlgO6xdyEExdAZntLIYy/RuohCvltPHy9arrCLoGIc2QZUMa3S65EAMSD8jaJPn66NwAPWXSuAAlULImnMl2otHJLlqA40BXRNh2f0WUnjSiguxseT6tE40XvuAK0aQ8jlawABAI8fmjp9ZxkLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P7MON2iWI/h3+9OoggbUoNR4jQG/293YAowNDfH1yuE=;
 b=kG3WJbpnyE7HJW8YASUDfqu3g1swjL6dbjGNYxDXMugA/HnfA8aZ+eL1IkilXjrHPNLscR2aPxRMr+xEAk7LpC92Mw4prySSsYpcC7x4QV/6XkgtzH7nt1cy/aISpyjwne1ewaLNiClrDAWyJCj/ai2Ol/GULH0WScRlZcPoJWhJ3RqN8fmnSNGOKcVI7VUOeCYWcZD8R0xrwUHNcN9C70Q23DePzqWB2oYVEMZ4dsJJiKDE4U/uAnXRfu0ZQtCqlpAEm3nZlBGP9NKj2rRqpEhlrfs0tZDR7X6EIPys2mmX1nxby93x41JyNyl6SlCR51mpJXNV4u0HTBQ+2flyEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P7MON2iWI/h3+9OoggbUoNR4jQG/293YAowNDfH1yuE=;
 b=PUrBDL0cyeeSyozXeGlXceGlvvv434dAVI3hTna7pjMqiMc607UfTA58qQOvwtWNHKRZTTLsokWxTNnwKiFMxWZbG2Yq6ZLnieyFCBNx2IELw9+EuHiQeq5gr1rJf+9cACJi6tbS8no7wyWzgLgZe88c0kh60uvToqRnAZSgSPQtFh2vn75J7FiUN1P1HTpE8EjeoRGr1xVu4lyXqfflPOy+cavGWf72/FX3CiFVBt9myUph3kFQn+YP5NDhNSzfO65dXrhzibyeduVgMajJWkkx+Zzs6rwtOz12XygPs/najIqXRxegjZXeMB66Zz7LeE7KkykTvojIFEjU7+N6XA==
Received: from OSQPR06MB7252.apcprd06.prod.outlook.com (2603:1096:604:29c::6)
 by TYZPR06MB5906.apcprd06.prod.outlook.com (2603:1096:400:333::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.16; Mon, 4 Nov
 2024 07:45:56 +0000
Received: from OSQPR06MB7252.apcprd06.prod.outlook.com
 ([fe80::814e:819a:7d52:7448]) by OSQPR06MB7252.apcprd06.prod.outlook.com
 ([fe80::814e:819a:7d52:7448%4]) with mapi id 15.20.8137.013; Mon, 4 Nov 2024
 07:45:56 +0000
From: Billy Tsai <billy_tsai@aspeedtech.com>
To: Akinobu Mita <akinobu.mita@gmail.com>, Krzysztof Kozlowski
	<krzk@kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Jean Delvare
	<jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>
Subject: Re: [PATCH v2 2/2] dt-bindings: hwmon: pwm-fan: add
 retain-state-shutdown property
Thread-Topic: [PATCH v2 2/2] dt-bindings: hwmon: pwm-fan: add
 retain-state-shutdown property
Thread-Index:
 AQHbJ33nzUvUzWmfmEOHL30M1fRtN7KbEXGAgAENKgCAABwRgIAACcyAgAMqcoCAAARkAIAHU3zY
Date: Mon, 4 Nov 2024 07:45:56 +0000
Message-ID:
 <OSQPR06MB72525057883A59578441E0988B512@OSQPR06MB7252.apcprd06.prod.outlook.com>
References: <20241026080535.444903-1-akinobu.mita@gmail.com>
 <20241026080535.444903-3-akinobu.mita@gmail.com>
 <ijdk5uuurnfd2shnwwj2nm64bno6lmrhdyqp42pzjc3i2e5cyh@v5ljkrsgo6ac>
 <CAC5umyitFp7oGR-eYXMVaS8bY1AGe3QwEuSPoEz3DxWwH=dUsA@mail.gmail.com>
 <e29e2c9e-60c1-4f32-ab71-e74f331e1921@kernel.org>
 <CAC5umyhCw+62Y+h3Jvh3=0Ocs8XJsSu_vaiPpO_g=65Jo4vUFg@mail.gmail.com>
 <e4985609-0642-4ff4-b074-8c5a34f88a24@kernel.org>
 <CAC5umyhrNCA4BHqC_k_tSaSOANcvP_vt485650xtFTPwJ+6snQ@mail.gmail.com>
In-Reply-To:
 <CAC5umyhrNCA4BHqC_k_tSaSOANcvP_vt485650xtFTPwJ+6snQ@mail.gmail.com>
Accept-Language: en-US, zh-TW
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSQPR06MB7252:EE_|TYZPR06MB5906:EE_
x-ms-office365-filtering-correlation-id: 18e131ac-4b0f-4427-e28d-08dcfca4b79c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|7416014|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?jXERBDhuhMlO0JYqHFWicvpFM8cfS3G6i/4KJO3jfHQMkin6IbBOGH5PF0?=
 =?iso-8859-1?Q?Sqf1neVv6b7rXmK47oAy0l2xx2lz4zrDfuaq7KedZ1lwTKwPHkM9TiKB0B?=
 =?iso-8859-1?Q?UoJtq95fVeQhzhepSlOqBNm32frFbA9/XDbWZgtx2NxjhXOmddmnI9DXJT?=
 =?iso-8859-1?Q?RTED1v0jt1kNmfhih7Tvo6JsSgNdPUfjKukKzWDOo1PCsBixbYV2hf1knt?=
 =?iso-8859-1?Q?FtGCNR/6o5DfQeIBZbvIJ/CDm5X/hK03Y+Zjj9ac/JFJAEk5u17Z1gDxH9?=
 =?iso-8859-1?Q?pSmhpZNVxkAF/HTVZnyXq98BiaJ3upIKJR8pQxKWhHFipSS5/z9g+Dfpo+?=
 =?iso-8859-1?Q?yIA8yY5oxHqz4jm1XrkXviljhcB/5m8dxzbBdNHmQ7kvaCjZ86B7GB6SB+?=
 =?iso-8859-1?Q?HZf3zCly4avgfOWNIUVhfS/A7ZtGoVFqc9lwDwk+oSZwCQPdlsngsdZ5+V?=
 =?iso-8859-1?Q?Ex8Pk0lDqP5RYfpJ9pRFbuUxalLYMmMa4wEMoTHBkVnYOotAk6wCeI5YQE?=
 =?iso-8859-1?Q?eXUjyOJgEmbP14jKl912Z+tWJvfpmiLlQVAHI6RonA5CkN+frdd1ScR0NQ?=
 =?iso-8859-1?Q?ItCzvqSv5hJgn7xu6FPXfGoJOq6jqql2E+nz8MfBF/AcNr3LNTs12o2xL2?=
 =?iso-8859-1?Q?GyumC9d4S8R/2M/CzBybGBYfi6xkB9AMHb08yweGbugMYTQAMEjiTlP/4k?=
 =?iso-8859-1?Q?Mmhj5g7dU+DhmtGvH7UAnAuBscDKu+78+l6lcX6lO9S5UNqHWR6SBym8Ur?=
 =?iso-8859-1?Q?sr2spkid+eVL3jp7Yu1CBXRQQ9BooNS6TI57rMlj9PVoBHYDg6tMsVo/Wp?=
 =?iso-8859-1?Q?oVK9juEfeRYuvFP+qX2luammYiZ0lDrNNEr/+FYcFV56XBUfIu5eEtdI4w?=
 =?iso-8859-1?Q?TiP5wlHClDzwq4l6MbSpgH/p4GGu0rS2/GQm2f9jUG3khS1LvSb8gOp0p2?=
 =?iso-8859-1?Q?N2pWx0hStB+ho7J2+Q1d+VDD9W5f1k/JiwJD9ADlzvukmjlemKZXx7ScR5?=
 =?iso-8859-1?Q?7wlT1ZwWT58FQlBn6QOtVBnGFKh9zDOvCfXrve0mOLhbCH13ntVXydm14G?=
 =?iso-8859-1?Q?2Er7FQZybES14Iv2HJU7jJAz+/evA0nZb1LZhZbvhZ8WDELSqChqTnSfPJ?=
 =?iso-8859-1?Q?3nNkUAtBA8JuY0gn9FpvBWQBjNdoMPzLOXcUAEeaiYB9ZcjfWF1zzncXLy?=
 =?iso-8859-1?Q?bw4YbvyyyJ9Uq6LR8/HYbAUfqFW3ZA4VRRBpKK8+SuisWMhezbwtxZoLRy?=
 =?iso-8859-1?Q?iu8MGWqlDUkpFriQDJtmdcx4XukZfBVPEvW6cY+2EQtNA+LGZvE5pgN2g6?=
 =?iso-8859-1?Q?ibVIwznrDPqOgcuAmyqD5f4AOfJCX09OnOpdpX2pqlew5k+HYaoozcLyVG?=
 =?iso-8859-1?Q?GtS+XO04pMyKj1f1NPdnpdAvt6N6sRKULVwFWt0MWssE4TdKh8H3s=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSQPR06MB7252.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?yJCftbfhP7h7uPbvF7sKElhmVoIZyvqD5jezdahhzbaBzZos4n7Ydg5SQF?=
 =?iso-8859-1?Q?y1u9P3vAZpwJZ/j2brZICHF9FJKcr4L66KQZ7TSc2o5CbWSZRK9ylCBPEC?=
 =?iso-8859-1?Q?X+yAp+ficWcrZ0QFmcXo1gVBig90q3/k2R19SasUENr6Wf2iU3QDB5GMZ7?=
 =?iso-8859-1?Q?/mI++EwKJzgkth5Tp5onS2Yk1q+bGfWLQree6pvswYKJPbTfI3abSELv9X?=
 =?iso-8859-1?Q?GJXDYyojyNib8jXRYRKA83pOKwF9zMe+7fjmYwVqTEQQfCOBBT4fk6kyfS?=
 =?iso-8859-1?Q?REN9dHMvUA7JI11X20hMvSIkJXkp55N+HZ8iuFWnWp3oHBLqiEUozwZKxF?=
 =?iso-8859-1?Q?Uvz9svydba2NWN5UbqCobEUiXRkBCA3rqDbhz14ye6RhiaexDquat11PDx?=
 =?iso-8859-1?Q?0/IlTIry84J9H3CHY0sOoey29VdVRrHCahYbPX3d5Nah/oArdUa7KVITyT?=
 =?iso-8859-1?Q?e0k0kfzZtyfiOgOUsjz+dP5d/ubkvNndsnl1C45NuIYw3+LdFsTspnphos?=
 =?iso-8859-1?Q?L9/eDOSyTEY0KfpdsDPAUa9LSXg2DoS3Spm4Ngn5bwmC3xdfTUpnAzodeu?=
 =?iso-8859-1?Q?WfvPexfW8R9UBGckYLgwHlKjBmoalVvsI1W4+ueiTO6bJv0N6nysv4O1x0?=
 =?iso-8859-1?Q?vtM2OsKu8DhlC5n0yuQs06x/S75p0MdzV7o5aTqIkcnSuHHoTSN52Rw6IO?=
 =?iso-8859-1?Q?fQbyjuuGzmNr8Vv356OVQg5gbwQ7Y2pn51EHryw7HSX/9b7hZfDHvYw5V+?=
 =?iso-8859-1?Q?z4fnEwVI4afBp4UxVGcZE3u6q+BZ055IPteAJb1xljqEG0mbDdfmwu1pXi?=
 =?iso-8859-1?Q?vo0OolT53esZ5dQ37I0uL37kqOoUKZeDcdiMyvjJrtrsUkv/v4Mk1+k+gJ?=
 =?iso-8859-1?Q?D0lP1uOFBMD22Spp9GSHCREYJ8b5EDyOk7Ug4cin7jSV66NySMACwLAPrz?=
 =?iso-8859-1?Q?C9SkCnpz79Q7w5U8cqOnpqeSM2S9LjrTAxOU8VpA+x2NXptEISwtOuGYcC?=
 =?iso-8859-1?Q?ATj9faEUwQ5a3myJxSXh2Q1KgPXkweDs/oZ3qGMCqZEFZG7Dd8J1/ISzrB?=
 =?iso-8859-1?Q?05up6s9p+WUQ/iZPKcPjWWivZuD1Xmq3xfdOCC9B1HGKoA8zx2faTwbg7b?=
 =?iso-8859-1?Q?AXgLtNJCka3XR/6HHnGGmjMjZPezTj68q3Bu94ZWuq1YM8wOBvCHcpb9XY?=
 =?iso-8859-1?Q?5AwIFhALoY2DRYFSxwrXo64EdI/VsD3umW9f2SyLEiWdnBGiGicDxcbfDK?=
 =?iso-8859-1?Q?4c3Akk3EFAMAAuUbjfCdptzVvAyYMCs78C9BjW3pZyDwwDySupHkvNXy4e?=
 =?iso-8859-1?Q?gzRu0Pwv+Jl3TSdrnEXbu1KB0Jahy9Qzazbw0JSJ4GxiGtcuAKQndUdStc?=
 =?iso-8859-1?Q?XRJM55rCAylMl7qTs521b1BKxlPto9vtSWDdCgu73Ga4urRg0Vh+1fm75h?=
 =?iso-8859-1?Q?E+9NF1Ko54sbV7D9PjeP95MgVHlPCxMk4IdVe0p7iOp7vXX+dH/WwclcwJ?=
 =?iso-8859-1?Q?q1j7tyWqa7Z/CBHOSrSmYjbUZ92wTRnYELA7jhF1ykrTACZ03Q2QLDDc8+?=
 =?iso-8859-1?Q?KBQfmwQCDCsj22Wk7SQiqz8AjcDLTTZWiYjWo7IPbbk7qKOfJ+VEPAe+vR?=
 =?iso-8859-1?Q?ScVvegIGg7GLFAOabW7HsnbkSC7JBOoEdn?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSQPR06MB7252.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18e131ac-4b0f-4427-e28d-08dcfca4b79c
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Nov 2024 07:45:56.4895
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4biGN4s5NAZt/cNcoX4TLlSrTukiYfLbznccEzHQnV6TEgiN2p8PzuWVSP1efCLzQiTXGzHQkOgKQcmauDEc5TAUaQKf0P0CCtscQe9AX5U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB5906

> >=0A=
> > On 28/10/2024 15:57, Akinobu Mita wrote:=0A=
> > >>>>=0A=
> > >>>> You described the desired Linux feature or behavior, not the actua=
l=0A=
> > >>>> hardware. The bindings are about the latter, so instead you need t=
o=0A=
> > >>>> rephrase the property and its description to match actual hardware=
=0A=
> > >>>> capabilities/features/configuration etc.=0A=
> > >>>=0A=
> > >>> Is this description okay?=0A=
> > >>> (Reused the description of retain-state-shutdown in leds-gpio.yaml)=
=0A=
> > >>>=0A=
> > >>> description:=0A=
> > >>>   Retain the state of the PWM on shutdown. Useful in BMC systems, f=
or=0A=
> > >>>   example, when the BMC is rebooted while the host remains up, the =
fan=0A=
> > >>>   will not stop.=0A=
> > >>=0A=
> > >> Nothing improved in the property. You still say what the system shou=
ld=0A=
> > >> do. This is user-space choice, not DT.=0A=
> > >=0A=
> > > It seems better to implement it as a device attribute.=0A=
> >=0A=
> > I don't know about that. To repeat: if you say what system is supposed=
=0A=
> > to be doing, it is a policy. Describe the hardware and its configuratio=
n=0A=
> > and maybe this would be suitable for DT.=0A=
=0A=
> Billy, could you please write a proper description for this property?=0A=
> I'm not the right person for this.=0A=
=0A=
In our hardware, if the system reboots and power remains on the PWM control=
ler=0A=
will retain its original settings. However, the pwm-fan.c driver currently =
disables=0A=
the PWM controller during a system reboot. I need this property to prevent =
pwm-fan.c=0A=
from disabling the PWM when the system reboots.=0A=
In my point of view, the description can be:=0A=
Retain the state of the PWM on shutdown. Some platforms (e.g., BMC) will ma=
intain=0A=
the PWM status after the system reboot. Add this property to prevent the PW=
M from being=0A=
disabled during the system reboot.=0A=
=0A=
Thanks=0A=
=0A=
Billy Tsai=


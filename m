Return-Path: <linux-kernel+bounces-567298-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B9769A68450
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 05:51:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 19CB1179C7E
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 04:51:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62A0324E4CB;
	Wed, 19 Mar 2025 04:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jMVlWm5k"
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A0BD23A0;
	Wed, 19 Mar 2025 04:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742359861; cv=none; b=l+l6ag55NLoAFHvXXBOEYOi5O/4pirhMMK34VR7pEXW+7i30lNu11K6lCnxDqDoyDJt3awzWgSclL/ik+skAS4MSoOfV9Y/hGetRaHcHZH8FV9leJtPQDr7bIcPpEAAXEbWL2dZqy9QPT4MAKszYPQwX+44JYpJbPpnMX11SqEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742359861; c=relaxed/simple;
	bh=YGkXe1uIWFDjueK4tldhxgOzxh6mW6oKolJQ8Btxx2A=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=Gogtv1UhvFU63E7KuM4dTdsnhdMP99UNG1s9UIlEjCZjc/8EC7kFCwJD/9+6hAKO+5e5Sh7HhGqH8wYcDYVKzK5tZgz12rTl16vNuGqLXFbEhvwtGYZEkJg5s06KBNb1y7YD3MsgXBI5WMG7/uu55nKscSwlxYIvKUEboXyqecc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jMVlWm5k; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2ff797f8f1bso6423606a91.3;
        Tue, 18 Mar 2025 21:51:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742359859; x=1742964659; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=YGkXe1uIWFDjueK4tldhxgOzxh6mW6oKolJQ8Btxx2A=;
        b=jMVlWm5kvyzHeG3TdAwPGCLrelKavyrqkDxX4+O6x3N74Z9hY5Dx11C3HmwZ3gO2+s
         3CoRE1+G2H8CBpcoIOZHfvVm8+izbADQYB8YuR/fGD/AmKfYY5FpeW0g3/3CnWbM9iUi
         w7HQ5MnFn9ldeWLKdvnqPz700eosx7WDgOL4As/BIqnxdDD0Pf0O8Lh0jcqM0/48GikZ
         HK7lZG53vzaUrefGen1Pu2yVUnSMy5bIyU2IffdwA0VmdaND6jUaUNQJiQMkBs5lJBli
         HlzHb6Dqof5cVsgK1ZiKNY2/PoRlUJPp3IT+gR0/TeB4vmt5YMGHTtLOsY0VkszsvwmZ
         wjpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742359859; x=1742964659;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YGkXe1uIWFDjueK4tldhxgOzxh6mW6oKolJQ8Btxx2A=;
        b=j2NcB2NVGzEmUKxUJqcX0PTnxtSl0KBnc9S1WMImQva4BGLx5dnkjXQKDloC3q03iP
         a4tVXlru9JUf1LzNetcYOk+xDycO1Z0hkwjgrrFeS8FoHfA/2p/c7N8OXnEpxsmaNZ+g
         PmPrDux2JRknu/vH1RzvILxBGEE7ZadlHYCPJJoWdbOPdVOoMWmQ5tLpvEb2DX3lq8jA
         ykpZ0T/nIHDz1ZLf9SxdU/6zB4lrE0D9w/cWcf6iYLO0bQBDlbP65hnBgyCovp/RstkV
         ZzcwS8o4g7zSL+1QZoFN13yvBio5z/ozM7CH9+IO3YezYpLhjuu2SFT/GjK98UlgRtsL
         1j/w==
X-Forwarded-Encrypted: i=1; AJvYcCVtneKp0k0KxDU7K6BPCJYm42s1ZsSOipDZACo83opssPxNqPOvIr/0htPZMAHbZ71nqHAdYjVRoK0=@vger.kernel.org, AJvYcCWxhWCDnK0pNPCBUaiysjB8zHLXX+yZAYNy01hjJGRYaeJv1m/vwILj1tMuLgrKa9f+DeTCNK4DtPEWstX3tWqLNmJLRQ==@vger.kernel.org, AJvYcCXoQdrkbYqaJ6GvmqPED47uBPgRZgFEQyDofXqHRap64bMTG6eighIynThto3N8jQDh2Jr+F3M4gb4p5qOq@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8Z3EV++cg32zvX8GubN4ReGqCa2rTDmqrgehsIjrid7Rel+tr
	GrhFa5LIEznFtXrj1V0TrSUIZWTs7ddNb8dQhkmtd8wOz2RigTKr
X-Gm-Gg: ASbGncvZBlqVfK59+OJjPzDuhm3J4s6Cnabw9TppqCP26UQiRnxs+S9CAz9r24SNJEn
	7ZIxaAugaE2q6yK4L/xQn+4vvNGqVpcDy5hf8eBhMOk6SSEaNHrdFTOeQ3ZI1S5rAYFMRddMYpG
	YhVTmpGYFULYtjSjUa0RPDP/js8bFazRC0v2HQfgtNih/QkyKf6hCgX2vbNb0H2RkSSfwck+9Zo
	PyY2GLKnKOWes9N1XpaQff5mKVy422JoCWzTbm2EDjLEsBX+vj67sCx1eBbQmsadbKdKzvQ4GPo
	8NyxIno5K9uRLX/O1dCJzS1SseCRbNil2Vz+0CcK6B+4prUqwrmZ
X-Google-Smtp-Source: AGHT+IFsMBNweAZbL0GQWVUBp9OBz+osa2zNdarSlaIzDkHpzsEjtNIGYixesG/XNRJAu1quiLF91A==
X-Received: by 2002:a17:90b:3b51:b0:2fe:955d:cdb1 with SMTP id 98e67ed59e1d1-301be1e7319mr1863217a91.23.1742359859487;
        Tue, 18 Mar 2025 21:50:59 -0700 (PDT)
Received: from ?IPv6:::1? ([2607:fb90:74e1:402a:ad3:2458:5234:fd64])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-301bf63d9e0sm468697a91.48.2025.03.18.21.50.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Mar 2025 21:50:59 -0700 (PDT)
Date: Tue, 18 Mar 2025 18:50:55 -1000
From: "Derek J. Clark" <derekjohn.clark@gmail.com>
To: Bagas Sanjaya <bagasdotme@gmail.com>, Hans de Goede <hdegoede@redhat.com>,
 =?ISO-8859-1?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
CC: Armin Wolf <W_Armin@gmx.de>, Jonathan Corbet <corbet@lwn.net>,
 Mario Limonciello <superm1@kernel.org>, Luke Jones <luke@ljones.dev>,
 Xino Ni <nijs1@lenovo.com>, Zhixin Zhang <zhangzx36@lenovo.com>,
 Mia Shao <shaohz1@lenovo.com>, Mark Pearson <mpearson-lenovo@squebb.ca>,
 "Pierre-Loup A . Griffais" <pgriffais@valvesoftware.com>,
 "Cody T . -H . Chiu" <codyit@gmail.com>, John Martens <johnfanv2@gmail.com>,
 platform-driver-x86@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v4_1/6_RESEND=5D_platform/x86?=
 =?US-ASCII?Q?=3A_Add_lenovo-wmi-*_driver_Documentation?=
User-Agent: Thunderbird for Android
In-Reply-To: <Z9pLFaSOPCF7G40s@archie.me>
References: <20250317144326.5850-1-derekjohn.clark@gmail.com> <20250317144326.5850-2-derekjohn.clark@gmail.com> <Z9pLFaSOPCF7G40s@archie.me>
Message-ID: <33BD9018-8B34-4CCF-B026-8500EFF934CD@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



On March 18, 2025 6:41:57 PM HST, Bagas Sanjaya <bagasdotme@gmail=2Ecom> w=
rote:
>On Mon, Mar 17, 2025 at 07:43:21AM -0700, Derek J=2E Clark wrote:
>> +=2E=2E SPDX-License-Identifier: GPL-2=2E0-or-later
>> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> +Lenovo WMI Interface Gamezone Driver (lenovo-wmi-gamezone)
>> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>><snipped>=2E=2E=2E
>> +=2E=2E SPDX-License-Identifier: GPL-2=2E0-or-later
>> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> +Lenovo WMI Interface Other Mode Driver (lenovo-wmi-other)
>> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
>I get htmldocs warnings due to SPDX line not being separated with title
>heading:
>
>Documentation/wmi/devices/lenovo-wmi-gamezone=2Erst:2: WARNING: Explicit =
markup ends without a blank line; unexpected unindent=2E [docutils]
>Documentation/wmi/devices/lenovo-wmi-other-method=2Erst:2: WARNING: Expli=
cit markup ends without a blank line; unexpected unindent=2E [docutils]
>

Acked=2E

>> +The Other Mode WMI interface uses the firmware_attributes class to exp=
ose
>> +various WMI attributes provided by the interface in the sysfs=2E This =
enables
>> +CPU and GPU power limit tuning as well as various other attributes for
>> +devices that fall under the "Gaming Series" of Lenovo devices=2E Each
>> +attribute exposed by the Other Mode interface has corresponding
>> +capability data blocks which allow the driver to probe details about t=
he
>> +attribute=2E Each attribute has multiple pages, one for each of the pl=
atform
>> +profiles managed by the Gamezone interface=2E Attributes are exposed i=
n sysfs
>> +under the following path:
>> +
>> +::
>> +/sys/class/firmware-attributes/lenovo-wmi-other/attributes/<attribute>=
/
>
>sysfs path above isn't outputted as literal code block as it lacks indent=
ation
>in the block text=2E
>
>Thanks=2E
>

Acked as well=2E

Thanks,
Derek


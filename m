Return-Path: <linux-kernel+bounces-532648-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EB5EA45042
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 23:34:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 489C6188CA31
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 22:34:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5318E194A44;
	Tue, 25 Feb 2025 22:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N01MsTTw"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAC2C18C32C;
	Tue, 25 Feb 2025 22:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740522832; cv=none; b=DG80wAxfMSgadN833VB31szaZvhb+FLmbfEgwl7OL1NKStlIJdoNFMf2TcmEyfmHcuaw8tU1BiwdpbjdOoDQdpD/AfYfEsXns5m1J7ELuuPO9aoNmEyGnBkJCkubfTLuj1R/uRIK6dPfA1fTbjRFSs7M/Cyx8z97lw8UTBSF7V4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740522832; c=relaxed/simple;
	bh=Q8Mvt4b5rEpHAvK7mdytQOZv3b0A5XpdpfLwtFmpubY=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=asslSFDLOgBfuYtdKZXeUPCuj4QwJDXPzb5oXLiRMrV1f0uL4rh4Mw632Y8tEWRadZQxzHdlstqE4TFrCnou1oC29U3SJUQj+ZUgou/O38BehnRQxt4nOo1sM4uNcKGYXw+1cS8B1xLDwx/HrfT/aPigcfbA23WNEHyR43/2yuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N01MsTTw; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-220e6028214so135067755ad.0;
        Tue, 25 Feb 2025 14:33:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740522830; x=1741127630; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=QFCrBdCg6yxE5RcbpuEM65U5YGSpZAEim2JIkrDhLsc=;
        b=N01MsTTwkEg95/2U2KJzzcXYOkRRTPR6nuWIfmYPak+5QpPVI3zWEtboPwEr4XpH69
         hs/fWgJQqO1u1v00BYInZkg6ZbmtKBgTpXqUiQy+H4tvTvDxMMABQ2FAXhABBYPkYWEN
         4Hdj/Ec0Ix5uhfCz9P9tcHJHcVKWop5SM0rGPDpBpCXFnVq7RBzg73dnXleYsuFrbUCj
         C8xch+WAf6PXNvz/EzV8Y/LBVW7gaBoGv1SMs5W6xFdZ7EEqQx0aZwJwt/qamWxf1fN7
         +efUsHIvzVmcGVUneCwnled9fCfoCJXp7N1tk+UPCysw8DPczb68jBCsf4GtU/K0OwFe
         CtMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740522830; x=1741127630;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QFCrBdCg6yxE5RcbpuEM65U5YGSpZAEim2JIkrDhLsc=;
        b=EfCc+dwZgvUBIbRShpJoi2iJgOgnBM0Ii1hPkbZ0IHm326+9+uFmR1+B5fPAkBXzW6
         IwFq5dMQtBAGqdAzMzeui7zDVYeq5jdyY0GR1OPLal4SI2TllXGwR9WNjkQl5QemfpED
         8HonSYOLnydOF7GlYmVnlq8d1Hw4Fod44YDisdMSqHnXomvfUF3lxdwgd0v7LIM5NeIL
         vOaUyN8yh4sPTHq1aP8wUIKsf5MhrA56YXQdBJd/dZpYv/UxL6F7zE+eUW25S7pbNo0x
         XvEXWvjQLVurrSmK991OXjbyqjwsqMoM0czYUbIJairoF/2C7p6FseDOyCKYnalKi6mt
         zNUQ==
X-Forwarded-Encrypted: i=1; AJvYcCUGeDUixWEemGpFjYZrs6FQECZhBEzHo3cQzIZ9C7Y1f18bXocwAysGmu5PeQdoliUWHADsSJXlt5rhmpNh@vger.kernel.org, AJvYcCWeph5SNyT3+payZFCmFeUMX9XMeEKWI4+zqVOOqw26EzNf/ODv8f/tJMOplFa/wHNs7/gYlPEHJlo=@vger.kernel.org, AJvYcCXEN2Hcam2MGjKqScM3h1Fdk7IJRxDtixy5MRCmRmbqt6cHYtG/qRJL17sNaXg45XkvVnMRyQ2LQ1nmerZo9lfiiajypg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0F0apYfz0rqT39V3CH+3n0cWOLEfm3I2kSr1OTho7heu2oU6V
	4vOhNl2gELKlwOVEjbFq1Lo/DqUZwDfhxRrZsm0yCo8U9l86XcIs
X-Gm-Gg: ASbGncsevrD7zl/U/lBO4Nrt8MIjjhGna+hKTqlu4NC8svCNVSpzRX2VTDlxLIYL+GC
	+xPxbK2azx7a/LG6p4mq2YKKVZqSeZgZ8o01eCFPTLJS0x79f1bZEXw7dE0fv9x2i3zWQYHIuVv
	7qRlhvatkONDjNo4D9KDv0oN+aNQCc9PGxJ2CI/y+ihRRbyenhx0AzADXq+0cyIi/dWVwHWhn0h
	HWnEXruTG9DlOYtpm8hmMWCN6ntPTipXBG7xOgvcMG4fyxZlCsqRtEtSsQoeKN5YqaRWSm35i+b
	wSthO33u1JZ72i/WcDJj3OtgDZQculitf8AC5jNvEFVgrckSu57du8oWZXxm2qa5nVVbYYPiTpA
	oOhpYnq1Mfg==
X-Google-Smtp-Source: AGHT+IH2o4vsrXuzNXh1HTiF4Gqyni2A05h21R9/e9/cqCb2ywwxvcVNPnUpWvSmqKT968iHUn1l4w==
X-Received: by 2002:a05:6a00:190b:b0:730:75b1:720a with SMTP id d2e1a72fcca58-73426d98ed2mr31674551b3a.23.1740522830015;
        Tue, 25 Feb 2025 14:33:50 -0800 (PST)
Received: from [127.0.0.1] (108-228-232-20.lightspeed.sndgca.sbcglobal.net. [108.228.232.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7347a6b8a82sm2049780b3a.6.2025.02.25.14.33.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Feb 2025 14:33:49 -0800 (PST)
Date: Tue, 25 Feb 2025 14:33:50 -0800
From: "Derek J. Clark" <derekjohn.clark@gmail.com>
To: Hans de Goede <hdegoede@redhat.com>,
 =?ISO-8859-1?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
CC: Armin Wolf <W_Armin@gmx.de>, Jonathan Corbet <corbet@lwn.net>,
 Mario Limonciello <superm1@kernel.org>, Luke Jones <luke@ljones.dev>,
 Xino Ni <nijs1@lenovo.com>, Zhixin Zhang <zhangzx36@lenovo.com>,
 Mia Shao <shaohz1@lenovo.com>, Mark Pearson <mpearson-lenovo@squebb.ca>,
 "Pierre-Loup A . Griffais" <pgriffais@valvesoftware.com>,
 "Cody T . -H . Chiu" <codyit@gmail.com>, John Martens <johnfanv2@gmail.com>,
 platform-driver-x86@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v3_3/4=5D_platform/x86=3A_Add?=
 =?US-ASCII?Q?_Lenovo_Capability_Data_01_WMI_Driver?=
User-Agent: Thunderbird for Android
In-Reply-To: <20250225220037.16073-4-derekjohn.clark@gmail.com>
References: <20250225220037.16073-1-derekjohn.clark@gmail.com> <20250225220037.16073-4-derekjohn.clark@gmail.com>
Message-ID: <FA54687F-F5EF-48FB-946F-E84BE06F2867@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



On February 25, 2025 1:59:54 PM PST, "Derek J=2E Clark" <derekjohn=2Eclark=
@gmail=2Ecom> wrote:
>Adds lenovo-wmi-capdata01=2Ec which provides a driver for the
>LENOVO_CAPABILITY_DATA_01 WMI data block that comes on "Other Mode"
>enabled hardware=2E Provides an interface for querying if a given
>attribute is supported by the hardware, as well as its default_value,
>max_value, min_value, and step increment=2E
>v3:
>- Add as component to lenovo-wmi-other driver=2E
>v2:
>- Use devm_kmalloc to ensure driver can be instanced, remove global
>  reference=2E
>- Ensure reverse Christmas tree for all variable declarations=2E
>- Remove extra whitespace=2E
>- Use guard(mutex) in all mutex instances, global mutex=2E
>- Use pr_fmt instead of adding the driver name to each pr_err=2E
>- Remove noisy pr_info usage=2E
>- Rename capdata_wmi to lenovo_wmi_cd01_priv and cd01_wmi to priv=2E
>- Use list to get the lenovo_wmi_cd01_priv instance in
>  lenovo_wmi_capdata01_get as none of the data provided by the macros
>  that will use it can pass a member of the struct for use in
>  container_of=2E
>
>Signed-off-by: Derek J=2E Clark <derekjohn=2Eclark@gmail=2Ecom>
>---
> MAINTAINERS                                 |   1 +
> drivers/platform/x86/Kconfig                |   5 +
> drivers/platform/x86/Makefile               |   1 +
> drivers/platform/x86/lenovo-wmi-capdata01=2Ec | 140 ++++++++++++++++++++
> drivers/platform/x86/lenovo-wmi=2Eh           |  19 +++
> 5 files changed, 166 insertions(+)
> create mode 100644 drivers/platform/x86/lenovo-wmi-capdata01=2Ec
>
>diff --git a/MAINTAINERS b/MAINTAINERS
>index cf7f4fce1a25=2E=2Ef6d3e79e50ce 100644
>--- a/MAINTAINERS
>+++ b/MAINTAINERS
>@@ -13157,6 +13157,7 @@ L:	platform-driver-x86@vger=2Ekernel=2Eorg
> S:	Maintained
> F:	Documentation/wmi/devices/lenovo-wmi-gamezone=2Erst
> F:	Documentation/wmi/devices/lenovo-wmi-other=2Erst
>+F:	drivers/platform/x86/lenovo-wmi-capdata01=2Ec
> F:	drivers/platform/x86/lenovo-wmi-gamezone=2Ec
> F:	drivers/platform/x86/lenovo-wmi=2Ec
> F:	drivers/platform/x86/lenovo-wmi=2Eh
>diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
>index 875822e6bd65=2E=2E56336dc3c2d0 100644
>--- a/drivers/platform/x86/Kconfig
>+++ b/drivers/platform/x86/Kconfig
>@@ -475,6 +475,11 @@ config LENOVO_WMI_GAMEZONE
> 	  To compile this driver as a module, choose M here: the module will
> 	  be called lenovo-wmi-gamezone=2E
>=20
>+config LENOVO_WMI_DATA01
>+	tristate
>+	depends on ACPI_WMI
>+	select LENOVO_WMI
>+
> config IDEAPAD_LAPTOP
> 	tristate "Lenovo IdeaPad Laptop Extras"
> 	depends on ACPI
>diff --git a/drivers/platform/x86/Makefile b/drivers/platform/x86/Makefil=
e
>index 4a7b2d14eb82=2E=2Ebe9031bea090 100644
>--- a/drivers/platform/x86/Makefile
>+++ b/drivers/platform/x86/Makefile
>@@ -70,6 +70,7 @@ obj-$(CONFIG_YT2_1380)		+=3D lenovo-yoga-tab2-pro-1380-=
fastcharger=2Eo
> obj-$(CONFIG_LENOVO_WMI)	+=3D lenovo-wmi=2Eo
> obj-$(CONFIG_LENOVO_WMI_CAMERA)	+=3D lenovo-wmi-camera=2Eo
> obj-$(CONFIG_LENOVO_WMI_GAMEZONE)	+=3D lenovo-wmi-gamezone=2Eo
>+obj-$(CONFIG_LENOVO_WMI_DATA01)	+=3D lenovo-wmi-capdata01=2Eo
>=20
> # Intel
> obj-y				+=3D intel/
>diff --git a/drivers/platform/x86/lenovo-wmi-capdata01=2Ec b/drivers/plat=
form/x86/lenovo-wmi-capdata01=2Ec
>new file mode 100644
>index 000000000000=2E=2E0fe156d5d770
>--- /dev/null
>+++ b/drivers/platform/x86/lenovo-wmi-capdata01=2Ec
>@@ -0,0 +1,140 @@
>+// SPDX-License-Identifier: GPL-2=2E0-or-later
>+/*
>+ * LENOVO_CAPABILITY_DATA_01 WMI data block driver=2E This interface pro=
vides
>+ * information on tunable attributes used by the "Other Mode" WMI interf=
ace,
>+ * including if it is supported by the hardware, the default_value, max_=
value,
>+ * min_value, and step increment=2E
>+ *
>+ * Copyright(C) 2024 Derek J=2E Clark <derekjohn=2Eclark@gmail=2Ecom>
>+ */
>+
>+#include <linux/cleanup=2Eh>
>+#include <linux/component=2Eh>
>+#include <linux/container_of=2Eh>
>+#include <linux/device=2Eh>
>+#include <linux/gfp_types=2Eh>
>+#include <linux/types=2Eh>
>+#include <linux/wmi=2Eh>
>+#include "lenovo-wmi=2Eh"
>+
>+/* Interface GUIDs */
>+#define LENOVO_CAPABILITY_DATA_01_GUID "7A8F5407-CB67-4D6E-B547-39B3BE01=
8154"
>+
>+static int lenovo_cd01_component_bind(struct device *cd01_dev,
>+				      struct device *om_dev, void *data)
>+{
>+	struct lenovo_wmi_cd01 *cd01 =3D dev_get_drvdata(cd01_dev);
>+	struct lenovo_wmi_om *om =3D dev_get_drvdata(om_dev);
>+
>+	om->cd01 =3D cd01;
>+	return 0;
>+}
>+
>+static void lenovo_cd01_component_unbind(struct device *cd01_dev,
>+					 struct device *om_dev, void *data)
>+
>+{
>+	struct wmi_device *om_wdev =3D
>+		container_of(om_dev, struct wmi_device, dev);
>+	struct lenovo_wmi_om *om =3D
>+		container_of(&om_wdev, struct lenovo_wmi_om, wdev);
>+
>+	om->cd01 =3D NULL;
>+}
>+
>+static const struct component_ops lenovo_cd01_component_ops =3D {
>+	=2Ebind =3D lenovo_cd01_component_bind,
>+	=2Eunbind =3D lenovo_cd01_component_unbind,
>+};
>+
>+static int lenovo_wmi_cd01_setup(struct lenovo_wmi_cd01 *cd01)
>+{
>+	size_t cd_size =3D sizeof(struct capdata01);
>+	int count, idx;
>+
>+	count =3D wmidev_instance_count(cd01->wdev);
>+
>+	cd01->capdata =3D devm_kmalloc_array(&cd01->wdev->dev, (size_t)count,
>+					   sizeof(*cd01->capdata), GFP_KERNEL);
>+	if (!cd01->capdata)
>+		return -ENOMEM;
>+
>+	cd01->instance_count =3D count;
>+
>+	for (idx =3D 0; idx < count; idx++) {
>+		union acpi_object *ret_obj __free(kfree) =3D NULL;
>+		struct capdata01 *cap_ptr =3D
>+			devm_kmalloc(&cd01->wdev->dev, cd_size, GFP_KERNEL);
>+		ret_obj =3D wmidev_block_query(cd01->wdev, idx);
>+		if (!ret_obj)
>+			continue;
>+
>+		if (ret_obj->type !=3D ACPI_TYPE_BUFFER)
>+			continue;
>+
>+		if (ret_obj->buffer=2Elength !=3D cd_size)
>+			continue;
>+
>+		memcpy(cap_ptr, ret_obj->buffer=2Epointer,
>+		       ret_obj->buffer=2Elength);
>+		cd01->capdata[idx] =3D cap_ptr;
>+	}
>+	return 0;
>+}
>+
>+static int lenovo_wmi_cd01_probe(struct wmi_device *wdev, const void *co=
ntext)
>+
>+{
>+	struct lenovo_wmi_cd01 *cd01;
>+	int ret;
>+
>+	cd01 =3D devm_kzalloc(&wdev->dev, sizeof(*cd01), GFP_KERNEL);
>+	if (!cd01)
>+		return -ENOMEM;
>+
>+	cd01->wdev =3D wdev;
>+
>+	ret =3D lenovo_wmi_cd01_setup(cd01);
>+	if (ret)
>+		return ret;
>+
>+	dev_set_drvdata(&wdev->dev, cd01);
>+
>+	ret =3D component_add(&wdev->dev, &lenovo_cd01_component_ops);
>+
>+	return ret;
>+}
>+
>+static void lenovo_wmi_cd01_remove(struct wmi_device *wdev)
>+{
>+	component_del(&wdev->dev, &lenovo_cd01_component_ops);
>+}
>+
>+static const struct wmi_device_id lenovo_wmi_cd01_id_table[] =3D {
>+	{ LENOVO_CAPABILITY_DATA_01_GUID, NULL },
>+	{}
>+};
>+
>+static struct wmi_driver lenovo_wmi_cd01_driver =3D {
>+	=2Edriver =3D {
>+		=2Ename =3D "lenovo_wmi_cd01",
>+		=2Eprobe_type =3D PROBE_PREFER_ASYNCHRONOUS,
>+	},
>+	=2Eid_table =3D lenovo_wmi_cd01_id_table,
>+	=2Eprobe =3D lenovo_wmi_cd01_probe,
>+	=2Eremove =3D lenovo_wmi_cd01_remove,
>+	=2Eno_singleton =3D true,
>+};
>+
>+int lenovo_wmi_cd01_match(struct device *dev, void *data)
>+{
>+	return dev->driver =3D=3D &lenovo_wmi_cd01_driver=2Edriver;
>+}
>+EXPORT_SYMBOL_GPL(lenovo_wmi_cd01_match);
>+

This should have been an EXPORT_SYMBOL_NS_GPL in the CAPDATA_WMI namespace=
=2E I thought I changed it but must have dropped it by mistake=2E I will fi=
x this next time=2E

- Derek

>+module_wmi_driver(lenovo_wmi_cd01_driver);
>+
>+MODULE_DEVICE_TABLE(wmi, lenovo_wmi_cd01_id_table);
>+MODULE_AUTHOR("Derek J=2E Clark <derekjohn=2Eclark@gmail=2Ecom>");
>+MODULE_DESCRIPTION("Lenovo Capability Data 01 WMI Driver");
>+MODULE_LICENSE("GPL");
>diff --git a/drivers/platform/x86/lenovo-wmi=2Eh b/drivers/platform/x86/l=
enovo-wmi=2Eh
>index 113928b4fc0f=2E=2E07fa67ed89d6 100644
>--- a/drivers/platform/x86/lenovo-wmi=2Eh
>+++ b/drivers/platform/x86/lenovo-wmi=2Eh
>@@ -45,6 +45,22 @@ enum lenovo_wmi_action {
> 	THERMAL_MODE_EVENT =3D 1,
> };
>=20
>+/* capdata01 structs */
>+struct lenovo_wmi_cd01 {
>+	struct capdata01 **capdata;
>+	struct wmi_device *wdev;
>+	int instance_count;
>+};
>+
>+struct capdata01 {
>+	u32 id;
>+	u32 supported;
>+	u32 default_value;
>+	u32 step;
>+	u32 min_value;
>+	u32 max_value;
>+};
>+
> /* wmidev_evaluate_method helper functions */
> int lenovo_wmidev_evaluate_method_2(struct wmi_device *wdev, u8 instance=
,
> 				    u32 method_id, u32 arg0, u32 arg1,
>@@ -52,6 +68,9 @@ int lenovo_wmidev_evaluate_method_2(struct wmi_device *=
wdev, u8 instance,
> int lenovo_wmidev_evaluate_method_1(struct wmi_device *wdev, u8 instance=
,
> 				    u32 method_id, u32 arg0, u32 *retval);
>=20
>+/* lenovo_wmi_cd01_driver match function */
>+int lenovo_wmi_cd01_match(struct device *dev, void *data);
>+
> /* lenovo_wmi_gz_driver notifier functions */
> int lenovo_wmi_gz_notifier_call(struct notifier_block *nb, unsigned long=
 action,
> 				enum platform_profile_option *profile);

- Derek


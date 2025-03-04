Return-Path: <linux-kernel+bounces-543284-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 21103A4D3C9
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 07:24:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E6633AE77A
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 06:23:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D034C1F4E5D;
	Tue,  4 Mar 2025 06:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h5UHhJg/"
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FBA51F4611;
	Tue,  4 Mar 2025 06:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741069429; cv=none; b=t6Ho0j8nZmDQkuABBAcrs4xSnpSbbbM8B9+ww6f5RV5rah1xLsmkl1gO7wbH4tiiWzj20jQxmAXr48RIUZJeXVYC/qfl5DWsL0wUmdlQD75mLx+K/0+U6cKPiQ7kR/LJsA3jxzNhQpNo7kMMMvq2djxNk7YjoiE/mS1o1Ui6dsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741069429; c=relaxed/simple;
	bh=qM6nzWU59w7y5QIHA+NK/RTyMJt9argx6ArxIGu4q7Q=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qhS1SlRW+UCH4zePpU8ZbAUYahx1IdMJX4hfM9rbze9gXQ0AtvBgxr84sxpBTQNazZr5mTBgEQeEyWKBczDQ1NeydDgQjXEqdeQ+GJohNAJfpDu7li0Bn1W+DjQjuluKgWENQY++X9ZW+OVi4MB0bESpg9GJCX8y6civUm/nIZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h5UHhJg/; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-7289871af1eso1017398a34.1;
        Mon, 03 Mar 2025 22:23:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741069427; x=1741674227; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LsFPwJO5HkMNkZKtQtsHb6wDsOU2hAWmu+ONuIeET/c=;
        b=h5UHhJg/LXQyNrsc3mssCos7KeBlviC9NKRZ1Eo7R8JCg7mIzUJxqOwUTwFnsmoAkH
         lo3NHDcHhX+bBppFWGUI0Dgpa/tukGYZ5JbfKmhuqJZTigpfjB5mQWCxIzcaeMajXRWq
         hitrEj8KMh608VYvoHXbQOSozh5iPNm0tpDpM24+ApGo5UhmS1w0BVeBxECWqT6iTdQM
         W6RtY3d1fFvndDadPHsrh6XEx9g+UhdXWkGiXcFxBcELQp8hKLv2gXMciGFjVKXJmID4
         0tA3uvqRCEwCcOC1RsC1KjbS2EHTkWPfiUA5NW7wDrPK2d5rVa2/m/xafAdktVasfl4U
         pNoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741069427; x=1741674227;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LsFPwJO5HkMNkZKtQtsHb6wDsOU2hAWmu+ONuIeET/c=;
        b=HgBoxI+tabpMAH+EZm6MYsIteDi6Xw+DJKVE9BOC8rS8S8Yr/wKVN1rpMHFjNjCom7
         913vsLHcvKXF3Kl4H9NbaRRGqfkraCECnnF+2pMkzDhFNDTZL8xxgM43RGjedBakwwP6
         /8KR5a1jNo8rYzFJMULNvuIbpik10zyA2BQ8KIoKqRkV3C19K+8IY7HrUSsje7KBsHsS
         7YYjBouv/hDuiNw3uDp1keACk4rBIbWMEP8nLWOMUWdxiH9jzFqzAurAwVk7qkSrfPwq
         Dl7/n4RXLfb7+IC+xvH7/CtMUtWz0yL4HEUQzHnMX89/ox9b0WKp+8dQvXSxNsOAx3/i
         HaWA==
X-Forwarded-Encrypted: i=1; AJvYcCVnuwxsJCNUgPXureVj/oYd8/h1lVtwJN/hi4kxDMduurUYVa30m3DDPLqLoe97m0zlEPdkEcqiOG64tCc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwCPfbgyH4UFCjFownYucoIgo1GKULvGWuq7hWR9i/kEAZ7h5d
	gesiQfsZYLfOHxPkjtd/FsbVOhiYXzFPGvwCqcDszmkNfvMroX+iC8WqamtE+jQ=
X-Gm-Gg: ASbGncvPaoiTtV7bO7BjjBEUmPlDoJK2CiH5VYMCXZZ6gqfk+nJKAHdWH0QMqz5Mebb
	TxGCeX4ueIxPKwRUxyFvuh3x2OfWw6Y6O1cRXyb4cEnIQxmpp8yNWxPB+WslC1dCYOM0MerbhGZ
	LeV5864I+5s2StEaDSlFS8jCuh/SPO1wHBg/GWvpUsYmJH8r8oA6/7ncwTu2qdd9FaTDp3pOcQH
	6AWK+vbxypoe/0EgkVm23ey1TH4OXFUvqcRWyObvwrFmqNBkc4r5WNXhqJeYRiq5qWSdQoUo9Lh
	Zr7do6OEUKpUFOQaZa3v9z3skdgzKcydwOREhcQ+tMEhk7XgSLk5EHL5VhLy
X-Google-Smtp-Source: AGHT+IFYVqT7e4pt9P1YxcLrzijcsKFOZitU1MKq1f72CECHf/FpON3LbG7oiifQOngyNTtxbg6AXg==
X-Received: by 2002:a05:6830:3693:b0:72a:fc7:21fa with SMTP id 46e09a7af769-72a0fc7230cmr3053301a34.27.1741069426732;
        Mon, 03 Mar 2025 22:23:46 -0800 (PST)
Received: from TM-Oleander.attlocal.net ([2600:1700:f7e0:e3e0:f5ed:3e21:9996:a1a9])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-72a0461b9cesm679824a34.25.2025.03.03.22.23.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 22:23:46 -0800 (PST)
From: Tadeu Marchese <marchese.kdev@gmail.com>
X-Google-Original-From: Tadeu Marchese <marchese@hp.com>
To: hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com
Cc: platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Tadeu Marchese <marchese@hp.com>
Subject: platform/x86/hp-bioscfg: Fix buffer alignment and conversion
Date: Tue,  4 Mar 2025 00:23:19 -0600
Message-Id: <20250304062319.86270-1-marchese@hp.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use PTR_ALIGN to access buffer in hp_get_string_from_buffer().
Remove code that escapes characters with backslashes.
Use kstrtouint() for unsigned string-to-integer conversion.
Increase the string_data buffer size by defining MAX_STRING_BUFF_SIZE.

Signed-off-by: Tadeu Marchese <marchese@hp.com>
---
This patch ensures proper alignment when reading the string size from the 
buffer and simplifies Unicode-to-UTF-8 conversion by removing 
unnecessary character escaping.

Issues fixed at the module initialization:
[  433.823905] hp_bioscfg: Prerequisites size value exceeded the maximum 
  number of elements supported or data may be malformed
[  433.837747] Unable to convert string to integer: 4294967295

The buffer size was too small for string attributes such as 
'HP_Disk0MapForUefiBootOrder'.

 drivers/platform/x86/hp/hp-bioscfg/bioscfg.c  | 82 ++++++-------------
 drivers/platform/x86/hp/hp-bioscfg/bioscfg.h  |  6 +-
 .../x86/hp/hp-bioscfg/int-attributes.c        |  8 +-
 3 files changed, 33 insertions(+), 63 deletions(-)

diff --git a/drivers/platform/x86/hp/hp-bioscfg/bioscfg.c b/drivers/platform/x86/hp/hp-bioscfg/bioscfg.c
index 0b277b7e37dd..b537fbaac15e 100644
--- a/drivers/platform/x86/hp/hp-bioscfg/bioscfg.c
+++ b/drivers/platform/x86/hp/hp-bioscfg/bioscfg.c
@@ -51,19 +51,21 @@ int hp_get_integer_from_buffer(u8 **buffer, u32 *buffer_size, u32 *integer)
 
 int hp_get_string_from_buffer(u8 **buffer, u32 *buffer_size, char *dst, u32 dst_size)
 {
-	u16 *src = (u16 *)*buffer;
+	u16 *src = PTR_ALIGN((u16 *)*buffer, sizeof(u16));
 	u16 src_size;
 
-	u16 size;
-	int i;
+	u16 length;
 	int conv_dst_size;
+	int result;
 
 	if (*buffer_size < sizeof(u16))
 		return -EINVAL;
 
+	/* String size is in the first two bytes of the buffer */
 	src_size = *(src++);
-	/* size value in u16 chars */
-	size = src_size / sizeof(u16);
+
+	/* Get the string length considering it is u16 */
+	length = src_size / sizeof(u16);
 
 	/* Ensure there is enough space remaining to read and convert
 	 * the string
@@ -71,54 +73,22 @@ int hp_get_string_from_buffer(u8 **buffer, u32 *buffer_size, char *dst, u32 dst_
 	if (*buffer_size < src_size)
 		return -EINVAL;
 
-	for (i = 0; i < size; i++)
-		if (src[i] == '\\' ||
-		    src[i] == '\r' ||
-		    src[i] == '\n' ||
-		    src[i] == '\t')
-			size++;
-
-	/*
-	 * Conversion is limited to destination string max number of
-	 * bytes.
-	 */
-	conv_dst_size = size;
-	if (size > dst_size)
-		conv_dst_size = dst_size - 1;
+	conv_dst_size = length;
+	if (dst_size < conv_dst_size)
+		return -EINVAL;
 
 	/*
-	 * convert from UTF-16 unicode to ASCII
+	 * Convert from UTF-16 unicode to UTF-8 and ensure
+	 * the string is null terminated
 	 */
-	utf16s_to_utf8s(src, src_size, UTF16_HOST_ENDIAN, dst, conv_dst_size);
-	dst[conv_dst_size] = 0;
-
-	for (i = 0; i < conv_dst_size; i++) {
-		if (*src == '\\' ||
-		    *src == '\r' ||
-		    *src == '\n' ||
-		    *src == '\t') {
-			dst[i++] = '\\';
-			if (i == conv_dst_size)
-				break;
-		}
-
-		if (*src == '\r')
-			dst[i] = 'r';
-		else if (*src == '\n')
-			dst[i] = 'n';
-		else if (*src == '\t')
-			dst[i] = 't';
-		else if (*src == '"')
-			dst[i] = '\'';
-		else
-			dst[i] = *src;
-		src++;
-	}
+	result = utf16s_to_utf8s(src, src_size, UTF16_HOST_ENDIAN, dst, conv_dst_size);
+	dst[result] = 0;
 
-	*buffer = (u8 *)src;
-	*buffer_size -= size * sizeof(u16);
+	/* Update buffer to point to the next position */
+	*buffer = (u8 *)src + src_size;
+	*buffer_size -= src_size;
 
-	return size;
+	return result;
 }
 
 int hp_get_common_data_from_buffer(u8 **buffer_ptr, u32 *buffer_size,
@@ -999,37 +969,37 @@ static int __init hp_init(void)
 	 */
 	ret = create_attributes_level_sysfs_files();
 	if (ret)
-		pr_debug("Failed to create sysfs level attributes\n");
+		pr_warn("Failed to create sysfs level attributes\n");
 
 	ret = hp_init_bios_attributes(HPWMI_STRING_TYPE, HP_WMI_BIOS_STRING_GUID);
 	if (ret)
-		pr_debug("Failed to populate string type attributes\n");
+		pr_warn("Failed to populate string type attributes\n");
 
 	ret = hp_init_bios_attributes(HPWMI_INTEGER_TYPE, HP_WMI_BIOS_INTEGER_GUID);
 	if (ret)
-		pr_debug("Failed to populate integer type attributes\n");
+		pr_warn("Failed to populate integer type attributes\n");
 
 	ret = hp_init_bios_attributes(HPWMI_ENUMERATION_TYPE, HP_WMI_BIOS_ENUMERATION_GUID);
 	if (ret)
-		pr_debug("Failed to populate enumeration type attributes\n");
+		pr_warn("Failed to populate enumeration type attributes\n");
 
 	ret = hp_init_bios_attributes(HPWMI_ORDERED_LIST_TYPE, HP_WMI_BIOS_ORDERED_LIST_GUID);
 	if (ret)
-		pr_debug("Failed to populate ordered list object type attributes\n");
+		pr_warn("Failed to populate ordered list object type attributes\n");
 
 	ret = hp_init_bios_attributes(HPWMI_PASSWORD_TYPE, HP_WMI_BIOS_PASSWORD_GUID);
 	if (ret)
-		pr_debug("Failed to populate password object type attributes\n");
+		pr_warn("Failed to populate password object type attributes\n");
 
 	bioscfg_drv.spm_data.attr_name_kobj = NULL;
 	ret = hp_add_other_attributes(HPWMI_SECURE_PLATFORM_TYPE);
 	if (ret)
-		pr_debug("Failed to populate secure platform object type attribute\n");
+		pr_warn("Failed to populate secure platform object type attribute\n");
 
 	bioscfg_drv.sure_start_attr_kobj = NULL;
 	ret = hp_add_other_attributes(HPWMI_SURE_START_TYPE);
 	if (ret)
-		pr_debug("Failed to populate sure start object type attribute\n");
+		pr_warn("Failed to populate sure start object type attribute\n");
 
 	return 0;
 
diff --git a/drivers/platform/x86/hp/hp-bioscfg/bioscfg.h b/drivers/platform/x86/hp/hp-bioscfg/bioscfg.h
index 3166ef328eba..99a95c709061 100644
--- a/drivers/platform/x86/hp/hp-bioscfg/bioscfg.h
+++ b/drivers/platform/x86/hp/hp-bioscfg/bioscfg.h
@@ -17,11 +17,11 @@
 
 #define DRIVER_NAME		"hp-bioscfg"
 
+#define MAX_STRING_BUFF_SIZE	1024
 #define MAX_BUFF_SIZE		512
 #define MAX_KEY_MOD_SIZE	256
 #define MAX_PASSWD_SIZE		64
 #define MAX_PREREQUISITES_SIZE	20
-#define MAX_REQ_ELEM_SIZE	128
 #define MAX_VALUES_SIZE		16
 #define MAX_ENCODINGS_SIZE	16
 #define MAX_ELEMENTS_SIZE	16
@@ -131,8 +131,8 @@ struct common_data {
 struct string_data {
 	struct common_data common;
 	struct kobject *attr_name_kobj;
-	u8 current_value[MAX_BUFF_SIZE];
-	u8 new_value[MAX_BUFF_SIZE];
+	u8 current_value[MAX_STRING_BUFF_SIZE];
+	u8 new_value[MAX_STRING_BUFF_SIZE];
 	u32 min_length;
 	u32 max_length;
 };
diff --git a/drivers/platform/x86/hp/hp-bioscfg/int-attributes.c b/drivers/platform/x86/hp/hp-bioscfg/int-attributes.c
index 6c7f4d5fa9cb..3e8f99b4174d 100644
--- a/drivers/platform/x86/hp/hp-bioscfg/int-attributes.c
+++ b/drivers/platform/x86/hp/hp-bioscfg/int-attributes.c
@@ -38,7 +38,7 @@ static int validate_integer_input(int instance_id, char *buf)
 	if (integer_data->common.is_readonly)
 		return -EIO;
 
-	ret = kstrtoint(buf, 10, &in_val);
+	ret = kstrtouint(buf, 10, &in_val);
 	if (ret < 0)
 		return ret;
 
@@ -55,7 +55,7 @@ static void update_integer_value(int instance_id, char *attr_value)
 	int ret;
 	struct integer_data *integer_data = &bioscfg_drv.integer_data[instance_id];
 
-	ret = kstrtoint(attr_value, 10, &in_val);
+	ret = kstrtouint(attr_value, 10, &in_val);
 	if (ret == 0)
 		integer_data->current_value = in_val;
 	else
@@ -185,7 +185,7 @@ static int hp_populate_integer_elements_from_package(union acpi_object *integer_
 		/* Assign appropriate element value to corresponding field*/
 		switch (eloc) {
 		case VALUE:
-			ret = kstrtoint(str_value, 10, &int_value);
+			ret = kstrtouint(str_value, 10, &int_value);
 			if (ret)
 				continue;
 
@@ -328,7 +328,7 @@ static int hp_populate_integer_elements_from_buffer(u8 *buffer_ptr, u32 *buffer_
 	integer_data->current_value = 0;
 
 	hp_get_string_from_buffer(&buffer_ptr, buffer_size, dst, dst_size);
-	ret = kstrtoint(dst, 10, &integer_data->current_value);
+	ret = kstrtouint(dst, 10, &integer_data->current_value);
 	if (ret)
 		pr_warn("Unable to convert string to integer: %s\n", dst);
 	kfree(dst);
-- 
2.40.1



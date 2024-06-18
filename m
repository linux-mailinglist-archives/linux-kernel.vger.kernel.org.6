Return-Path: <linux-kernel+bounces-218566-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 78F5490C1EE
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 04:54:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27E5F283DBE
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 02:54:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93A8519B3C3;
	Tue, 18 Jun 2024 02:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kfocus-org.20230601.gappssmtp.com header.i=@kfocus-org.20230601.gappssmtp.com header.b="X+rBiOWZ"
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AC60197A7B
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 02:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718679262; cv=none; b=ZElN9uLZzPkndRPOXpCoHRHPWIvlqbIBHAijf9iiGlQ+HZlKDMDhr72m7dJAxY/0w+09mhucUFcjjTb5O857R1Glru3rEW3aWsQC+ZZI6/5n3YkKdkJXotGUeW0s9vx/zTqNHsi2Il/B4xtpkTxh0ImK6kgKevS22f+UqnQNwEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718679262; c=relaxed/simple;
	bh=4j0EvQkQ9xJAUqlZ8bWcy54HxYyBb02BLfp17lE/u6E=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=fjGwmbhGotWuM7i6ishPjeea5hJLC6jPA/vcC/8CXt52I0nLAdFhAqTXu7RCgXovY3xf5UWbrMzLFaB+92PFxba7fiZwgVhoBzvfpJRMWQmsRvsIFePNr1Cp4+lrQcxgzCUNwjVjwcDHbsWJgqxQGJc5tNCsfSG0smvSP31DeTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kfocus.org; spf=pass smtp.mailfrom=kfocus.org; dkim=pass (2048-bit key) header.d=kfocus-org.20230601.gappssmtp.com header.i=@kfocus-org.20230601.gappssmtp.com header.b=X+rBiOWZ; arc=none smtp.client-ip=209.85.166.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kfocus.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kfocus.org
Received: by mail-io1-f43.google.com with SMTP id ca18e2360f4ac-7ebde93bf79so224010739f.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 19:54:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kfocus-org.20230601.gappssmtp.com; s=20230601; t=1718679260; x=1719284060; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=911Yzpdxj/p69u1bVziccAshKYL3Ktlrp0ENvO+HyZU=;
        b=X+rBiOWZURKYhDJj8ggITvqQcNvPaMM90QRswKclVhG3JOEqM/YKgROH3nK6/ENnUQ
         3TN9T0GILZIP9AIOk11aped/atRcgHr7sJcbo7PDYfeCDg8TEVu6NC5P5SATCd1/APuP
         7mQg+jnaHH0NrNNouTgAebpusmpgKZhHFrgexJuojl/rJ1GF8wg6oDDNaiRXFf5BtmJh
         mFPIVZA+1HWjCcWFKyLfwHHca8q6yo8GCNRGAwjOONNEMCVMQk2DcAGNo2G8qYDcTASk
         I+WOK9A/DlaC1QvUSp3ido2+YZYWklLu4owbq1whasVz8s9Dc3Ina8U764yAA09ZvLp4
         AN1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718679260; x=1719284060;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=911Yzpdxj/p69u1bVziccAshKYL3Ktlrp0ENvO+HyZU=;
        b=Cg8e14KiRvRoVDDIAxNcwu51I1K6SD3yCgMHDw0+e5sT3kUCJWZNNXNvGdURrJjwn6
         t6UO+e7cVgiOQpIRmONx7s/AW4VDnc8CZ/JZRSpB6Ev6rWRaEDVeblzSEr4H5gaeO4pg
         5x7RWUNzkwHfbmbUhchSbiN8eB8P85jLf1OYqcUR0DR0DMR1R8eFE/9LOwJdIRk1p8Yu
         rNssrn1I9mJKN5kI2M9e9olYOmJPT1C2dMGXJiMcjMbZI6I/Udx0kFz3pKclF6OpitEx
         4CUSL9GHKTTPuXYiZV4DGKaptR+sZbARmYPocyPxj/TDJfRpnJS++KjvWmC3KxSAn7PB
         Ysng==
X-Forwarded-Encrypted: i=1; AJvYcCUC7vzZWIN3SY+i2JQMh7hx9R/3JwcjTEklyIi+za8IpSrmyBuD3s13Z0dTKLVF6hwsixGNTXmZz5ZcrCpC1Mj9nj9QdjxXE5lf2vZB
X-Gm-Message-State: AOJu0Yw6+7Wq9X5Q03r1FsnwLMdbxXR/noxUwmSXmDMPtiUCoNCDSdhj
	IeUaScNe2K/V4aw/WqIFjsgD2CbmszSSVfjR9xy+eD+VQwi8rJIcZIo2HKlnrOg=
X-Google-Smtp-Source: AGHT+IFtYOzppYAG8HWgNrS/JIDEK2crHyhIyRM15PBmmmZQkpZZi9moaBfyES7RS8gS8+LVuTzjpQ==
X-Received: by 2002:a05:6602:140a:b0:7eb:4770:6ea2 with SMTP id ca18e2360f4ac-7ebeb4b4fe9mr1402072239f.5.1718679260204;
        Mon, 17 Jun 2024 19:54:20 -0700 (PDT)
Received: from kf-XE ([2607:fb91:111c:4643:b5f:d6ad:8a73:5578])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4b956a21890sm3006114173.129.2024.06.17.19.54.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jun 2024 19:54:19 -0700 (PDT)
Date: Mon, 17 Jun 2024 21:54:17 -0500
From: Aaron Rainbolt <arainbolt@kfocus.org>
To: linux-acpi@vger.kernel.org, rafael@kernel.org
Cc: mario.limonciello@amd.com, lenb@kernel.org,
	linux-kernel@vger.kernel.org, mmikowski@kfocus.org
Subject: [PATCH] acpi: Allow ignoring _OSC CPPC v2 bit via kernel parameter
Message-ID: <ZnD22b3Br1ng7alf@kf-XE>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

acpi: Allow ignoring _OSC CPPC v2 bit via kernel parameter

The _OSC is supposed to contain a bit indicating whether the hardware
supports CPPC v2 or not. This bit is not always set, causing CPPC v2 to
be considered absent. This results in severe single-core performance
issues with the EEVDF scheduler.

To work around this, provide a new kernel parameter,
"processor.ignore_osc_cppc_bit", which may be used to ignore the _OSC
CPPC v2 bit and act as if the bit was enabled. This allows CPPC to be
properly detected even if not "enabled" by _OSC, allowing users with
problematic hardware to obtain decent single-core performance.

Tested-by: Michael Mikowski <mmikowski@kfocus.org>
Signed-off-by: Aaron Rainbolt <arainbolt@kfocus.org>

---

diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
index 1d857978f5f4..53406dd6cb87 100644
--- a/drivers/acpi/cppc_acpi.c
+++ b/drivers/acpi/cppc_acpi.c
@@ -671,7 +671,7 @@ static inline void arch_init_invariance_cppc(void) { }
  *
  *	Return: 0 for success or negative value for err.
  */
-int acpi_cppc_processor_probe(struct acpi_processor *pr)
+int acpi_cppc_processor_probe(struct acpi_processor *pr, bool ignore_osc_cppc_bit)
 {
 	struct acpi_buffer output = {ACPI_ALLOCATE_BUFFER, NULL};
 	union acpi_object *out_obj, *cpc_obj;
@@ -686,7 +686,7 @@ int acpi_cppc_processor_probe(struct acpi_processor *pr)
 
 	if (!osc_sb_cppc2_support_acked) {
 		pr_debug("CPPC v2 _OSC not acked\n");
-		if (!cpc_supported_by_cpu()) {
+		if (!ignore_osc_cppc_bit && !cpc_supported_by_cpu()) {
 			pr_debug("CPPC is not supported by the CPU\n");
 			return -ENODEV;
 		}
diff --git a/drivers/acpi/processor_driver.c b/drivers/acpi/processor_driver.c
index 67db60eda370..a183bca6c1c5 100644
--- a/drivers/acpi/processor_driver.c
+++ b/drivers/acpi/processor_driver.c
@@ -33,6 +33,11 @@ MODULE_AUTHOR("Paul Diefenbaugh");
 MODULE_DESCRIPTION("ACPI Processor Driver");
 MODULE_LICENSE("GPL");
 
+static bool ignore_osc_cppc_bit = false;
+module_param(ignore_osc_cppc_bit, bool, 0);
+MODULE_PARM_DESC(ignore_osc_cppc_bit,
+	"Ignore _OSC CPPC bit, assume CPPC v2 is present");
+
 static int acpi_processor_start(struct device *dev);
 static int acpi_processor_stop(struct device *dev);
 
@@ -170,7 +175,7 @@ static int __acpi_processor_start(struct acpi_device *device)
 	if (pr->flags.need_hotplug_init)
 		return 0;
 
-	result = acpi_cppc_processor_probe(pr);
+	result = acpi_cppc_processor_probe(pr, ignore_osc_cppc_bit);
 	if (result && !IS_ENABLED(CONFIG_ACPI_CPU_FREQ_PSS))
 		dev_dbg(&device->dev, "CPPC data invalid or not present\n");
 
diff --git a/include/acpi/processor.h b/include/acpi/processor.h
index 3f34ebb27525..79fd61b3f537 100644
--- a/include/acpi/processor.h
+++ b/include/acpi/processor.h
@@ -358,10 +358,10 @@ int acpi_map_cpuid(phys_cpuid_t phys_id, u32 acpi_id);
 int acpi_get_cpuid(acpi_handle, int type, u32 acpi_id);
 
 #ifdef CONFIG_ACPI_CPPC_LIB
-extern int acpi_cppc_processor_probe(struct acpi_processor *pr);
+extern int acpi_cppc_processor_probe(struct acpi_processor *pr, bool ignore_osc_cppc_bit);
 extern void acpi_cppc_processor_exit(struct acpi_processor *pr);
 #else
-static inline int acpi_cppc_processor_probe(struct acpi_processor *pr)
+static inline int acpi_cppc_processor_probe(struct acpi_processor *pr, bool ignore_osc_cppc_bit)
 {
 	return 0;
 }


Return-Path: <linux-kernel+bounces-220485-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FC1E90E255
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 06:33:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02F0C28215E
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 04:33:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92F143DB89;
	Wed, 19 Jun 2024 04:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kfocus-org.20230601.gappssmtp.com header.i=@kfocus-org.20230601.gappssmtp.com header.b="BsV/oZYn"
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48D7A179AE
	for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 04:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718771614; cv=none; b=gqXrTWppJ7qtzDqzxPygvUkUwa+EwjA7xKr48G8nIlQ0Tve56QjeizgCFWHmYx50VDQZ0OYTN2CUQMuOjZYOeGwK31KZFV06ILsywoU+50/xJNvZP8L4xFImWvlrhPeVnCVc1okSOcmMKokCURyZShn5vPxBml8V4xa8kHGq378=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718771614; c=relaxed/simple;
	bh=l4w/LvYlB6QlwrMz9fQ/LSeC2pWpySat/4xzansMIl4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jLZTbG8GF1XLqgvR195Bb2STZ3W3fhooUY+o6iIF7UTnG43y1QGReYa7EJxQIJpENdeSC91JEuv/7qQe0hg8JSGe5CcmHLUrqgiFhwolUJsD4k+4lo+bS981XiYuVp9A4ooeF+NRA3UMim5FRPeWOgwJVeuSgfrLL/BpIG9poz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kfocus.org; spf=pass smtp.mailfrom=kfocus.org; dkim=pass (2048-bit key) header.d=kfocus-org.20230601.gappssmtp.com header.i=@kfocus-org.20230601.gappssmtp.com header.b=BsV/oZYn; arc=none smtp.client-ip=209.85.166.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kfocus.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kfocus.org
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-7eb7bf1357cso239538139f.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 21:33:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kfocus-org.20230601.gappssmtp.com; s=20230601; t=1718771612; x=1719376412; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NWlYdNwXcIt2Uj/WmtGcgNX4cntxb9XSir9I0MKekec=;
        b=BsV/oZYnjcRwcKgN0jA396kw6i3pE1roVC4RTq/qrsBzXvdjLYJ1bBRCAfYFrMsOLF
         sDy33TnfqAMea6eZqGNitJ1mOabovwVsaRUGFXlY0mATrLp/qzbgPxHxZai9jxZCkgft
         4G3/170cG+OpvLJJbsBXErZRPnsZudRbup448NlNXEz3BMkRE/mo58LAn2caM1i996XP
         3ZwGrnTkBFcK7NmgB1/83NwfnPMyiSzY6rGND5zv6CJ9NavBSkT8cbsTLg26ECl3bmzs
         suLOTERpcsNb2+749LakndoZrQZfx72zD9IriizX7OTeqgB2s+m6ibkQXc2rRt6uqx2Q
         74cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718771612; x=1719376412;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NWlYdNwXcIt2Uj/WmtGcgNX4cntxb9XSir9I0MKekec=;
        b=BaPOMx0f5KRzAuu6IQuX8V4jjB1EzX9arnjClC+zIFj8LKOHDUSbYFFqYCD8bItA39
         BD+2nBtAOpW15LS9xztb1RkfTPpGGZhFYL/XorymEGWGp1jp0AQLkfc7UIEDhRGlmmqh
         pnD9vwFHQPScPIk14ctyMfZTplFHPqmnptYBTaIkvYtKee82P3xr0bxsgVCtxw4Y+DU9
         6WFNQWzcRkLZS0Wy2mIAqCJd/h206o7PyE9q242FTJ1Bol93YE12IXhv4ukfCINQrouA
         0aSyF6l1JJGRwzy6TTVy8yBT85G0aTIxT5MDp8lc3HLHxTE1HRXLfg6myqGt8ccHqHwq
         /SWA==
X-Forwarded-Encrypted: i=1; AJvYcCX6BqmQ5clBYp3S0WdjqyjRk8DLyMNBhnl/9NmE7XBJng+vA7HbTcTxt+hBv6+l3cWu+QRhGmtZEj+ZznwRuQH8ScuddvoLKMo+KRmN
X-Gm-Message-State: AOJu0YzH5NiM87DQqWmnXLGaTpMnLyObVqRMVAPdc5Y8hrUqE0ZmBInZ
	b1pF336A5GTfQyzwINKjld5FYD2Wvtj62UM7B7Bxw+7lWxHW4HCZLKgcOsaeTxhV0XOZrqizNbb
	lm065wg==
X-Google-Smtp-Source: AGHT+IERVC8ibZcD8y1uku57YmVlXRCDnAChTM5lB2gA4zuk557SjUwxDXw/tQhWcQEXPUrzPE/adg==
X-Received: by 2002:a05:6602:6c10:b0:7eb:7f2e:5b3a with SMTP id ca18e2360f4ac-7f13edb2453mr214966539f.2.1718771612308;
        Tue, 18 Jun 2024 21:33:32 -0700 (PDT)
Received: from kf-XE ([2607:fb91:111c:4643:212e:5310:572e:1126])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4b9a1d0980fsm691665173.102.2024.06.18.21.33.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jun 2024 21:33:32 -0700 (PDT)
Date: Tue, 18 Jun 2024 23:33:29 -0500
From: Aaron Rainbolt <arainbolt@kfocus.org>
To: Mario Limonciello <mario.limonciello@amd.com>,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: rafael@kernel.org, lenb@kernel.org, mmikowski@kfocus.org,
	Perry.Yuan@amd.com
Subject: Re: [PATCH V3] acpi: Allow ignoring _OSC CPPC v2 bit via kernel
 parameter
Message-ID: <ZnJfmUXmU_tsb9pV@kf-XE>
References: <b516084f-909e-4ea4-b450-3ee15c5e3527@amd.com>
 <ZnHSKiaYf2tIQo58@kf-XE>
 <a7790c74-2bec-4a24-b6e5-223c4e1ed372@amd.com>
 <ZnHXfLEwk2uRbg58@kf-XE>
 <b4d65232-b69e-419d-9b15-d0ca64b78b26@amd.com>
 <ZnHfNbLTgY1op3Zv@kf-XE>
 <fb8c965a-5f1c-4975-8e7d-6f6a0eb4d02f@amd.com>
 <ZnHtPbszYT8afOOk@kf-XE>
 <c6bda238-166e-4de6-b0c7-4bddfb8ef6f4@amd.com>
 <ZnIAX9P5XSco4cZw@kf-XE>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZnIAX9P5XSco4cZw@kf-XE>

acpi: Allow ignoring _OSC CPPC v2 bit via kernel parameter

The _OSC is supposed to contain a bit indicating whether the hardware
supports CPPC v2 or not. This bit is not always set, causing CPPC v2 to
be considered absent. This results in severe single-core performance
issues with the EEVDF scheduler on heterogenous-core Intel processors.

To work around this, provide a new kernel parameter, "ignore_osc_cppc_bit",
which may be used to ignore the _OSC CPPC v2 bit and act as if the bit was
enabled. This allows CPPC to be properly detected even if not "enabled" by
_OSC, allowing users with problematic hardware to obtain decent single-core
performance.

Tested-by: Michael Mikowski <mmikowski@kfocus.org>
Signed-off-by: Aaron Rainbolt <arainbolt@kfocus.org>

---

V2 -> V3: Move bit ignore to before switch.
V1 -> V2: Rewrite to work in cpc_supported_by_cpu.

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index b600df82669d..af2d8973ba3a 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -2063,6 +2063,12 @@
                        could change it dynamically, usually by
                        /sys/module/printk/parameters/ignore_loglevel.

+       ignore_osc_cppc_bit
+                       Assume CPPC is present and ignore the CPPC v2 bit from
+                       the ACPI _OSC method. This is useful for working
+                       around buggy firmware where CPPC is supported, but
+                       _OSC incorrectly reports it as being absent.
+
        ignore_rlimit_data
                        Ignore RLIMIT_DATA setting for data mappings,
                        print warning at first misuse.  Can be changed via
diff --git a/arch/x86/kernel/acpi/cppc.c b/arch/x86/kernel/acpi/cppc.c
index ff8f25faca3d..0ca1eac826af 100644
--- a/arch/x86/kernel/acpi/cppc.c
+++ b/arch/x86/kernel/acpi/cppc.c
@@ -11,8 +11,20 @@

 /* Refer to drivers/acpi/cppc_acpi.c for the description of functions */

+static bool ignore_osc_cppc_bit;
+static int __init parse_ignore_osc_cppc_bit(char *arg)
+{
+       ignore_osc_cppc_bit = true;
+       return 0;
+}
+early_param("ignore_osc_cppc_bit", parse_ignore_osc_cppc_bit);
+
 bool cpc_supported_by_cpu(void)
 {
+       if (ignore_osc_cppc_bit) {
+               return true;
+       }
+
        switch (boot_cpu_data.x86_vendor) {
        case X86_VENDOR_AMD:
        case X86_VENDOR_HYGON:


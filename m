Return-Path: <linux-kernel+bounces-274453-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A84F0947840
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 11:22:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6A0D1C20FD3
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 09:22:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD3671514CE;
	Mon,  5 Aug 2024 09:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dyOwCvfO"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 852E014B972
	for <linux-kernel@vger.kernel.org>; Mon,  5 Aug 2024 09:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722849760; cv=none; b=rUfNB7Me5LBAZQ3U4cXAxU3fgZw1DOWjGdteZvS0elZM1GrBRn50f5kMbEnCazZ6YfcvLpO+kFu1Rnm8Zez1s44lFeFwLp4K0yaNGujtgUWDTJ56qGi3z6Ciq9F8jfH6o4PD1Kf9Pzefc0UdaxT9UkVOCxivn0I4IYie0DObZtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722849760; c=relaxed/simple;
	bh=RNt7467t59reJJ9TsUyPVqHux3gbzNGxcp7CHRuxwvQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kJeGiSfxtDXMDdtbi9gv/M2bYCly+WuHTaPBl0GlyM8G/lsyQEjVFzlXI0j+U0nfFAg0LVkX6ZDY3c/2cK40eYqeTJo8MFH34FmUAaELpc9w6bSf2tkO1Pg0rroRJj5c/8ufQw0OWl4u0wYasfq6jkWaK8zkf9ABh5KZ64m2lqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dyOwCvfO; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-52fcc56c882so3089204e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2024 02:22:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1722849757; x=1723454557; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TF5TZEidLD4MavlyyOC5NjaLSbReOigmuqt7PIdRnmc=;
        b=dyOwCvfO6QXcNhh99SgdmRS2aQsr7jigCeClQ9Kp7fre9Ls6L/zoVVOY+rhoBMEf2i
         gLFutNectZ+HBiaRc+YJoNZDdAAuurtJ6wQx6+TNmgwFg7x/r0jbLVA9vrbNjauTLOwD
         WcxPonkboOfYrre0Jyxyy9zCgopvfRm75TWgpIfcYC0ZkXBTr6D9qaGnqw9EWdOtK6C+
         ZTPvOkhj31dbcDVJSMaOwx5DYmG+gdBlKj4gLYiV8FLUmS9rDdNBxB+fWTlq1gOxrWt0
         uJEhfD7dZsr8PmLMf9f1SV6/Or3sG9cdNIN858dw8taqtfW1Gi6bOlR9Nc0ocIlp9/Ya
         7jEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722849757; x=1723454557;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TF5TZEidLD4MavlyyOC5NjaLSbReOigmuqt7PIdRnmc=;
        b=qZE3YUPSKoxy1Tz+RVSlFTiH012pHErvlJiAjxbZ688/Q90YnSNVSgZetMH0DmoC+x
         CKhDhVZfrTSLdbFjM2oXUJBYzxrAXqGF1ZID+8ZHkCvPZ7eF4TMZISI/2uEC32/ubyNm
         i+8NsOR3e2IKspWKq4rKpEC0qAT3UFgAi/oa/RKvCvkrI4800WSb2vcw6YZfj1Xe0ysr
         7f06yeB3IeitiPgOwycCuaksM46hIgofYCu2HIBmFpcuc/v4/BKodNavH06b5zO/GkhG
         wMPC4N0uE0YtuJC62eGqAcyjTPKX9eX3gUUgj33jy1tSOQAfaw6ExIE4pR3nc+Q2xQj5
         WV0Q==
X-Forwarded-Encrypted: i=1; AJvYcCXqGJNkGMMhw0O8+IR9b7D7J/2YOG4lAJ0Mbk/qYnj3WfTywrzAmOZ7Df6OGyg1d3OAlwIcCbZpgYxG3sSjKhb/bco1ULf8uds9qBCC
X-Gm-Message-State: AOJu0YxEDXsrh3JeHwRHmC8Iihz0JycElwuvM5legK2UWONOaONSLJhO
	6z+4NgKIIMNyWDTNk/UwOhgmRjxWrsLbrhMWip4sK/jv3i5g+ZQ97lPbL85H2po=
X-Google-Smtp-Source: AGHT+IH6CGUvtv6OgeI38NVq3w+aNPFmHUBTP9hKDP+SWBRqOZJlK4U2ymUb6pGpi/HRjsZySFuTow==
X-Received: by 2002:a05:6512:3045:b0:52f:31a:4c08 with SMTP id 2adb3069b0e04-530b8d0a343mr3740659e87.11.1722849756538;
        Mon, 05 Aug 2024 02:22:36 -0700 (PDT)
Received: from localhost (c-9b0ee555.07-21-73746f28.bbcust.telenor.se. [85.229.14.155])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-530bba10e15sm1061476e87.78.2024.08.05.02.22.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Aug 2024 02:22:36 -0700 (PDT)
From: Anders Roxell <anders.roxell@linaro.org>
To: masahiroy@kernel.org
Cc: linux-kbuild@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH v2] scripts: kconfig: merge_config: config files: add a trailing newline
Date: Mon,  5 Aug 2024 11:22:34 +0200
Message-ID: <20240805092234.1338866-1-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240802124236.2895857-1-anders.roxell@linaro.org>
References: <20240802124236.2895857-1-anders.roxell@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When merging files without trailing newlines at the end of the file, two
config fragments end up at the same row if file1.config doens't have a
trailing newline at the end of the file.

file1.config "CONFIG_1=y"
file2.config "CONFIG_2=y"
./scripts/kconfig/merge_config.sh -m .config file1.config file2.config

This will generate a .config looking like this.
cat .config
...
CONFIG_1=yCONFIG_2=y"

Making sure so we add a newline at the end of every config file that is
passed into the script.

Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 scripts/kconfig/merge_config.sh | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/scripts/kconfig/merge_config.sh b/scripts/kconfig/merge_config.sh
index 902eb429b9db..0b7952471c18 100755
--- a/scripts/kconfig/merge_config.sh
+++ b/scripts/kconfig/merge_config.sh
@@ -167,6 +167,8 @@ for ORIG_MERGE_FILE in $MERGE_LIST ; do
 			sed -i "/$CFG[ =]/d" $MERGE_FILE
 		fi
 	done
+	# In case the previous file lacks a new line at the end
+	echo >> $TMP_FILE
 	cat $MERGE_FILE >> $TMP_FILE
 done
 
-- 
2.43.0



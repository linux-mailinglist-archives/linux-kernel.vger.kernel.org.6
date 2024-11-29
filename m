Return-Path: <linux-kernel+bounces-425688-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 239FC9DE916
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 16:07:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D96C728196E
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 15:07:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FD0F149C7A;
	Fri, 29 Nov 2024 15:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bePqHZKT"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 448981474C9
	for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 15:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732892799; cv=none; b=DldJhytqB1V3PnVw/ZbQIqF7oBrwt4ESn5yfN5T9bCb6dmTN3Vx3QrQn6c0tt9ytbcV1JItl0AJ+EKk36RKwuRQoq7/Dce6QeTkNlZAKhZyfp65X0O5kk2jyyqDDgVvUBAjpPWzpjrCHnXYEnS92/5vg/e9Gdb+nGKWj7Z+5l84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732892799; c=relaxed/simple;
	bh=/u6sYDXYCv4BGbywn/oNfwqHt8utKfq52QYTXp3e+3c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OvVvraOO2JsUlAc0hNIl0qjWxMR2I1IRB6br3D7C6H/nAoFC3QVWCjXC1Vrg+vCPwgOHnZgE7lwG3NuezCfdmiXXWrOoU4NxQq/qg2U+/cFUpUTxGpAdGd+l+CtV2LCnYhq9XXhsz5qwjbYqLXY6H4G0zwCKMgTLnKpw/kOV1Zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bePqHZKT; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-434a742481aso17844405e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 07:06:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732892795; x=1733497595; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O1RxO6Y2JI3TfYtTzU3PRytsUBUMUtMEWiVHbRJqhOM=;
        b=bePqHZKTxhPmhqi8j0Juze2sZCEvr2qKTy4CMNKDjt6O595BRhtkIFJqykhRGYqOeT
         J4xqMhgGVz+64cu1rPtEbYqUzrAqVld8evgKBFWgTZIgk7xBGZrjbLBgwIVZP7kwnoBw
         HvZLROXd89xcRTrfZB8rKLDs+HiVaMg/LWSYeHIzsT4H+v4P/N90muyWc//f2GD8pPsI
         9p/abElus3XXAMYcPy0JQEuICZ/fINdLR/unhJQdbN3+e/PN/2YKbUPGtdbazXThljVw
         PVd5a7K0OZ/+GcVDOe1xhObLNfTed3WXpOUGz4m4X7YWWs7RZQbE+ftCYaZ/n/ey8KKY
         cM/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732892795; x=1733497595;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O1RxO6Y2JI3TfYtTzU3PRytsUBUMUtMEWiVHbRJqhOM=;
        b=izqYnP7xcJhjrWo6S+izwgIHcX5bi6V9BLKuOeektWGXc6FoFOdv9HDu9CxYDwaoDc
         KLWW4B7ogzy2XV+KbGCO8PJQmS5EhAZUjqyIADp81CWJbnZaD/7hwIebuUOyvmUw2MFi
         O6KO/rRQ0VCQI5rktTAPiauBRuUJcjStUeLkkr+ENNIX3OOy+yFaClOSs6Z2aAP913ME
         wiEQO0LjwJpGpQ9kJaNP3eVs7rQfAFq5q/WmMHkMNUDnQKqQitvAtjBcvEvYImeMGu4T
         S1ZnL2dUl4Kks2HACiMsCFrvmRur1VA1QCasaRbSXVurGF2BsjrHfyTyqBaPDxY4IFrW
         A96A==
X-Forwarded-Encrypted: i=1; AJvYcCXMpdxNuCdIK1bsS8ZQ/mWIjW2ZOotfHwG40xbYg9W1pBl72obxywdNCkuhEQRsVlBChTUaJMN7DVhsQ80=@vger.kernel.org
X-Gm-Message-State: AOJu0Yws3eK1BsPpiet6AVehq4WW+PdfjwGAUUBSTbs119CyHCHLrb4j
	dabVBmLnm0y0wP5xso2Mr8ZgFW1v9F/pWjtVoBmOCPLY0WXsDT1rZNTNM0F/hrw=
X-Gm-Gg: ASbGnctmc9yIn+k/V2OG/qbfeQvsyCoauQxc0dOm226rGWD80vDoJ8RF6XZYQ82lLt5
	jMV4cBsnXEPbx6npAy80aPNK2X+uD5etRCUFG4xrGjsAM2jcgGG9y3qoB6c43SVN00+hgRpKfKm
	P6fg8qdqsd2d1kLKRvg/jnaiyetGhwTVET/jHd7Cd4rnTIaBBlIXTbRTpqVUJYM8yznGT400eGY
	cpVjat1x8XMjwDiH76vYMWZsOdJA5M5oD4JPB66k39DwtPb0DhZL21EmSEYV+jGp5ZGNrQ=
X-Google-Smtp-Source: AGHT+IG/CLlNjoEeXqqCSqqj4fL806Db7a1DYqdpAMKbUKywm0zN5uM2fWirXPSE+NY3hA+7cOlanA==
X-Received: by 2002:a05:600c:314a:b0:434:a902:415b with SMTP id 5b1f17b1804b1-434a9dc3c69mr132703725e9.10.1732892789201;
        Fri, 29 Nov 2024 07:06:29 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-385ccd2df65sm4759637f8f.6.2024.11.29.07.06.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Nov 2024 07:06:28 -0800 (PST)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Fri, 29 Nov 2024 16:06:24 +0100
Subject: [PATCH v2 1/2] OPP: add index check to assert to avoid buffer
 overflow in _read_freq()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241129-topic-opp-fix-assert-index-check-v2-1-386b2dcbb9a6@linaro.org>
References: <20241129-topic-opp-fix-assert-index-check-v2-0-386b2dcbb9a6@linaro.org>
In-Reply-To: <20241129-topic-opp-fix-assert-index-check-v2-0-386b2dcbb9a6@linaro.org>
To: Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, 
 Stephen Boyd <sboyd@kernel.org>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=6914;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=/u6sYDXYCv4BGbywn/oNfwqHt8utKfq52QYTXp3e+3c=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBnSdhyfIAtt2Us5TEz48JeKKiN037BLucClkJeywUC
 f3FrfxaJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZ0nYcgAKCRB33NvayMhJ0V3/D/
 9lvrF19yw5+SOaT4CecCdQVl2+OK/yiiyvIkIpqnlmbN0cMOFEmU/z+HJ44168KikpaeBIMrThNRQb
 0oFt/8S/EfwYScFuIyRIeuB9DjHDEj1gNAJ+VD9zXtpfrnJjxu4AwzFDZhZRvnCQk0vv5+dmSce4Uw
 m6yRWn6gIe8f0wepZAPHLC6iMBfqKgM2fwQBU/euPEJCetXcxnwjcq5/RwyPSJ4zym7OdZtXm0OLmD
 4yogIQUjet/q13BTx76MW8vK5wj9Lo4n2SbjeqfX0ZT7dnXIGpB6zKsV+621DoR1aImOAp+x6T12Vr
 ITbDiAQDgJNBAm4tu/ShaElfNIqlEBtWkY6VgvBFtjuheiAJ/mKv9/h7l7y1KcLBnDsxO7JexnUSoh
 hwIOJvOqmUF0l5f0Og6r4f+7HoYu3EC40aktDbGqq+xnwI3qE1m5WI4hn6AbRSd0mv1m1tBk1akP80
 wYyFFN5Zq7v8pNriAZgONuS7+g7yEuesb03S8ZZKhc/9bMtWuvIZjsGZwTOKMRrIRVA/P1H2U0nYYr
 V44BDJczhK4d8eoYCYAZ0T8DpmtHJI/2ngQ6GmxViMh17p/lbGqRC1Zz5P7DjMeNF51M1z/u2VI2HT
 G0EOAdqKFUk4mEYk3g16lA5KnEEvtKncTY/lsgWYJgpkTC5VCNx0lKtvedeQ==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE

Pass the freq index to the assert function to make sure
we do not read a freq out of the opp->rates[] table when called
from the indexed variants:
dev_pm_opp_find_freq_exact_indexed() or
dev_pm_opp_find_freq_ceil/floor_indexed().

Add a secondary parameter to the assert function, unused
for assert_single_clk() then add assert_clk_index() which
will check for the clock index when called from the _indexed()
find functions.

Fixes: 142e17c1c2b4 ("OPP: Introduce dev_pm_opp_find_freq_{ceil/floor}_indexed() APIs")
Fixes: a5893928bb17 ("OPP: Add dev_pm_opp_find_freq_exact_indexed()")
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 drivers/opp/core.c | 40 +++++++++++++++++++++++++---------------
 1 file changed, 25 insertions(+), 15 deletions(-)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index d4a0030a0228d6282d672e3ffe3aeea27e80822a..52c6a45ceb7479c3ef0ed97ab43a37546d695c7f 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -101,11 +101,19 @@ struct opp_table *_find_opp_table(struct device *dev)
  * representation in the OPP table and manage the clock configuration themselves
  * in an platform specific way.
  */
-static bool assert_single_clk(struct opp_table *opp_table)
+static bool assert_single_clk(struct opp_table *opp_table, int __always_unused index)
 {
 	return !WARN_ON(opp_table->clk_count > 1);
 }
 
+/*
+ * Returns true if clock table is large enough to contain the clock index.
+ */
+static bool assert_clk_index(struct opp_table *opp_table, int index)
+{
+	return opp_table->clk_count > index;
+}
+
 /**
  * dev_pm_opp_get_bw() - Gets the bandwidth corresponding to an opp
  * @opp:	opp for which bandwidth has to be returned for
@@ -524,12 +532,12 @@ static struct dev_pm_opp *_opp_table_find_key(struct opp_table *opp_table,
 		unsigned long (*read)(struct dev_pm_opp *opp, int index),
 		bool (*compare)(struct dev_pm_opp **opp, struct dev_pm_opp *temp_opp,
 				unsigned long opp_key, unsigned long key),
-		bool (*assert)(struct opp_table *opp_table))
+		bool (*assert)(struct opp_table *opp_table, int index))
 {
 	struct dev_pm_opp *temp_opp, *opp = ERR_PTR(-ERANGE);
 
 	/* Assert that the requirement is met */
-	if (assert && !assert(opp_table))
+	if (assert && !assert(opp_table, index))
 		return ERR_PTR(-EINVAL);
 
 	mutex_lock(&opp_table->lock);
@@ -557,7 +565,7 @@ _find_key(struct device *dev, unsigned long *key, int index, bool available,
 	  unsigned long (*read)(struct dev_pm_opp *opp, int index),
 	  bool (*compare)(struct dev_pm_opp **opp, struct dev_pm_opp *temp_opp,
 			  unsigned long opp_key, unsigned long key),
-	  bool (*assert)(struct opp_table *opp_table))
+	  bool (*assert)(struct opp_table *opp_table, int index))
 {
 	struct opp_table *opp_table;
 	struct dev_pm_opp *opp;
@@ -580,7 +588,7 @@ _find_key(struct device *dev, unsigned long *key, int index, bool available,
 static struct dev_pm_opp *_find_key_exact(struct device *dev,
 		unsigned long key, int index, bool available,
 		unsigned long (*read)(struct dev_pm_opp *opp, int index),
-		bool (*assert)(struct opp_table *opp_table))
+		bool (*assert)(struct opp_table *opp_table, int index))
 {
 	/*
 	 * The value of key will be updated here, but will be ignored as the
@@ -593,7 +601,7 @@ static struct dev_pm_opp *_find_key_exact(struct device *dev,
 static struct dev_pm_opp *_opp_table_find_key_ceil(struct opp_table *opp_table,
 		unsigned long *key, int index, bool available,
 		unsigned long (*read)(struct dev_pm_opp *opp, int index),
-		bool (*assert)(struct opp_table *opp_table))
+		bool (*assert)(struct opp_table *opp_table, int index))
 {
 	return _opp_table_find_key(opp_table, key, index, available, read,
 				   _compare_ceil, assert);
@@ -602,7 +610,7 @@ static struct dev_pm_opp *_opp_table_find_key_ceil(struct opp_table *opp_table,
 static struct dev_pm_opp *_find_key_ceil(struct device *dev, unsigned long *key,
 		int index, bool available,
 		unsigned long (*read)(struct dev_pm_opp *opp, int index),
-		bool (*assert)(struct opp_table *opp_table))
+		bool (*assert)(struct opp_table *opp_table, int index))
 {
 	return _find_key(dev, key, index, available, read, _compare_ceil,
 			 assert);
@@ -611,7 +619,7 @@ static struct dev_pm_opp *_find_key_ceil(struct device *dev, unsigned long *key,
 static struct dev_pm_opp *_find_key_floor(struct device *dev,
 		unsigned long *key, int index, bool available,
 		unsigned long (*read)(struct dev_pm_opp *opp, int index),
-		bool (*assert)(struct opp_table *opp_table))
+		bool (*assert)(struct opp_table *opp_table, int index))
 {
 	return _find_key(dev, key, index, available, read, _compare_floor,
 			 assert);
@@ -672,7 +680,8 @@ struct dev_pm_opp *
 dev_pm_opp_find_freq_exact_indexed(struct device *dev, unsigned long freq,
 				   u32 index, bool available)
 {
-	return _find_key_exact(dev, freq, index, available, _read_freq, NULL);
+	return _find_key_exact(dev, freq, index, available, _read_freq,
+			       assert_clk_index);
 }
 EXPORT_SYMBOL_GPL(dev_pm_opp_find_freq_exact_indexed);
 
@@ -732,7 +741,8 @@ struct dev_pm_opp *
 dev_pm_opp_find_freq_ceil_indexed(struct device *dev, unsigned long *freq,
 				  u32 index)
 {
-	return _find_key_ceil(dev, freq, index, true, _read_freq, NULL);
+	return _find_key_ceil(dev, freq, index, true, _read_freq,
+			      assert_clk_index);
 }
 EXPORT_SYMBOL_GPL(dev_pm_opp_find_freq_ceil_indexed);
 
@@ -785,7 +795,7 @@ struct dev_pm_opp *
 dev_pm_opp_find_freq_floor_indexed(struct device *dev, unsigned long *freq,
 				   u32 index)
 {
-	return _find_key_floor(dev, freq, index, true, _read_freq, NULL);
+	return _find_key_floor(dev, freq, index, true, _read_freq, assert_clk_index);
 }
 EXPORT_SYMBOL_GPL(dev_pm_opp_find_freq_floor_indexed);
 
@@ -1727,7 +1737,7 @@ void dev_pm_opp_remove(struct device *dev, unsigned long freq)
 	if (IS_ERR(opp_table))
 		return;
 
-	if (!assert_single_clk(opp_table))
+	if (!assert_single_clk(opp_table, 0))
 		goto put_table;
 
 	mutex_lock(&opp_table->lock);
@@ -2079,7 +2089,7 @@ int _opp_add_v1(struct opp_table *opp_table, struct device *dev,
 	unsigned long tol, u_volt = data->u_volt;
 	int ret;
 
-	if (!assert_single_clk(opp_table))
+	if (!assert_single_clk(opp_table, 0))
 		return -EINVAL;
 
 	new_opp = _opp_allocate(opp_table);
@@ -2835,7 +2845,7 @@ static int _opp_set_availability(struct device *dev, unsigned long freq,
 		return r;
 	}
 
-	if (!assert_single_clk(opp_table)) {
+	if (!assert_single_clk(opp_table, 0)) {
 		r = -EINVAL;
 		goto put_table;
 	}
@@ -2911,7 +2921,7 @@ int dev_pm_opp_adjust_voltage(struct device *dev, unsigned long freq,
 		return r;
 	}
 
-	if (!assert_single_clk(opp_table)) {
+	if (!assert_single_clk(opp_table, 0)) {
 		r = -EINVAL;
 		goto put_table;
 	}

-- 
2.34.1



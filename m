Return-Path: <linux-kernel+bounces-305344-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 19BC6962D3E
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 18:05:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5AB72858A1
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 16:05:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F24C1A2C24;
	Wed, 28 Aug 2024 16:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DxyJ57EZ"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CD047E574;
	Wed, 28 Aug 2024 16:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724861128; cv=none; b=dRyveFn7wkHPg66GiZjhqx0zXd+6wQP5uxVsZmAPeohrNxvPgquU1o39ktf0mCPnPC8nBe57ssBr4NTykDPEm2Xsyusblwpfv0nQVv9WAtpzm2TuK6tzwx4k8ykDLMLWNXWuOIYor4B6bMxMDm6JwSIKdgiSF9UCl6phQd7vRyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724861128; c=relaxed/simple;
	bh=Co+ZoX9nlmvVIKGutVNONku1/Na4NsMBksYnyHdgsIY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qgIPPCciINlFsrHldVvAtHYvSCSb6iHERfchvF4CaIibaGUM0NS7CLB4fGms3t1V1pnnNlSdbW4cygsA1hqZ533MgT9EP9Wt+J280exCh8ujOjbQf9z1oX4zPH4P4fsv3iQps0nY8kZf0bvuamD40eHUbaKRIN7wEv1FdnVyrfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DxyJ57EZ; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-53345604960so7499720e87.3;
        Wed, 28 Aug 2024 09:05:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724861125; x=1725465925; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kosFjdk6GkyQVi+AThfAIGP1FTIA4D/dob1Vut4HNXM=;
        b=DxyJ57EZ5bUSF+dbUjpXk4TyJxgjVXI3AtWYiyaLfFd++ny+laFzhIxpbSvR3ucXUc
         pee/y3XRB/0vTjbWSgkEX8BaI2g3irzb5H6zwRNXdgEjD3qF7eOu6gyWjSfULHVQIefn
         x/AdXLxYqltI9cw5XaVd/mwLZXs/wjmtNDL1tWwZlukRkYcXRHAlqsPdKkSYZLXQlXm1
         05LslcLjCM30zb6+heRHn3BOJcavRtpGvaHK7s4oPa3b4GR6q9ImTIWIDm8jmIDumLd/
         aa3osbl4x/JgtBsJao4sBWAcTBYqV5EJf3VMjPJpgT/Kmr4m+iDZ8nBUmxY28xf46+3P
         RrBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724861125; x=1725465925;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kosFjdk6GkyQVi+AThfAIGP1FTIA4D/dob1Vut4HNXM=;
        b=OyPX0fF2a2CXFA5PMs00cgO/mDQVYh28JBZsAosjsIuH7jIBQ9kiWqS85+4pfZ1Jjm
         84blFZ1r+06+z6xejXAazxFXJ8tAKD8wQ2aRfCrBefIQjojBH+4AKwyFszRdk7imcjkN
         YQuQkyESbZ6Ivs/F1xIeN+a/PRsCtf+4gBN2/3Q2yzM/FnBaHz73HIB+8r95bFxenCRP
         CKBdh/5YVCiTJeBaKpd78Y67YmBKpniA5LuOJTxov6hO0cM9mDU9RI//FrEgq5wJ8Orx
         3E1Qu4flk8eFyf6AHZjS+oYcNmY7UWaNQ7ca4aWcYad6Z944AyjVVmeVixXh2Px96+wB
         kH0A==
X-Forwarded-Encrypted: i=1; AJvYcCVsaI5I7XkXC7h/SqCIip97gm04893zOIZ5h4M4Ci+fm0kaDXV/gcJ2MClnyFg7vVhCdSZ/wEHsPst1ccgG@vger.kernel.org, AJvYcCXypxWCsQPu8RCBr5nwEg2laKyz2BXBl0MLIAVXswqyizTvuqrIaDaFRlMOEo7T5udgyZ8WnqEVWl/aSA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy04jzHDNi0q3s+qa98CElQWYc1mTztunCAQ+5V4DeZGA5Z4nuF
	tTQjBkLWEB5SRjAz/5lHxom/luENtv8gbeQZOTy7bQ3c1dyh1inq
X-Google-Smtp-Source: AGHT+IF8cqYWal0brvhOLe0qRqU3sh07nqJ466gkpWctJCE4jZ4ugYsFvlQqJ1bO6yO2kpbpLZkyXA==
X-Received: by 2002:a05:6512:1111:b0:52c:8abe:51fb with SMTP id 2adb3069b0e04-5343875582emr11230031e87.10.1724861124497;
        Wed, 28 Aug 2024 09:05:24 -0700 (PDT)
Received: from localhost.localdomain ([78.209.220.215])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42ba6397de5sm26691585e9.8.2024.08.28.09.05.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2024 09:05:24 -0700 (PDT)
From: Antoni Pokusinski <apokusinski01@gmail.com>
To: linux@roeck-us.net
Cc: apokusinski01@gmail.com,
	jdelvare@suse.com,
	linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: Re: [PATCH v3] hwmon: (sht4x): add heater support
Date: Wed, 28 Aug 2024 18:05:11 +0200
Message-Id: <20240828160511.307768-1-apokusinski01@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <790f67c3-84f4-441b-bd80-0c11f002af5b@roeck-us.net>
References: <790f67c3-84f4-441b-bd80-0c11f002af5b@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

I've been thinking on how to approach the problem of NACKs received
from the sensor while the heater is on but I haven't found
a perfectly satisfying solution either. This is due to the fact that
the device does not provide any way to check if the heater is on/off.

1. I guess that the simplest possible approach would involve sleeping
in `heater_enable_store()`:
  
  ssize_t heater_enable_store() {
    ...
    mutex_lock(data->lock);
    ret = i2c_master_send(data->client, &cmd, SHT4X_CMD_LEN);
    msleep(...) /* for >100 or >1000 ms */
    mutex_unlock(data->lock);
    ...
  }

This way, the user would have to wait for the heating to complete in
order to read RH or temperature measurement. However, I find this
solution unacceptable since it's completely unnecessary for the user
to wait for the heating to complete.

2. A better solution could be possibly to use a wait queue in order
to defer the job of enabling the heater:

  struct sht4x_data {
    ...
    struct work_struct* heater_work; /* This would be initialized
                                        with the handler described
                                        below */
  }

The task of sending the "heater_enable" command and sleeping would be
performed by the worker function:

  static void heater_enable_handler(struct work_struct *work) {
    ...
    mutex_lock(data->lock);
    ret = i2c_master_send(data->client, &cmd, SHT4X_CMD_LEN);
    msleep(...) /* for >100 or >1000 ms */
    mutex_unlock(data->lock);
    ...
  }

And that above mentioned work would be scheduled
in `heater_enable_store()`:

  ssize_t heater_enable_store() {
    ...
    schedule_work(data->heater_work);
    ...
  }

I think that this approach with work queue is better since the user
doesn't have to wait for the heating to complete and the RH or
temperature measurements can also be retrieved without the NACK error
(even though the user still may have to wait for the heater to be
off), since the `data->lock` mutex is used to guard both measurement
reads from the sensor and the heating in `heater_enable_handler`.

I'm worried though about the situation where the user writes 1 to
"heater_enable" while it's already enabled. Since the `work_struct`
is already on the queue, the `heater_enable_store` would return an
error and I see no easy solution to this for now.

Regards,
Antoni Pokusinski


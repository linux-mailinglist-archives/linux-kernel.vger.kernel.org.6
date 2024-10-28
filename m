Return-Path: <linux-kernel+bounces-384097-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EC9EB9B243D
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 06:32:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4E95AB21C3B
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 05:32:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9889C18C93D;
	Mon, 28 Oct 2024 05:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ilXBkY/h"
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58C0D18B492;
	Mon, 28 Oct 2024 05:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730093505; cv=none; b=jIbHP6FWFgbi0gw4L011MixRN8OFr5tl0My9bW/NlbOZTiQ35H2yM4+BSWWmEY/LHvbSYKp8wnPrdHVfYJucxFPlcy+qcL8B0R07yK3AKV5aEaXY2FavcPMkAWD2tA+qqKLN184KPYjFgaGM2+GurzuDEH5PiaF5xl1o6Ba0uPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730093505; c=relaxed/simple;
	bh=aNPNOoKVsPojEBhxia3xk3JbPFV30hk8lKIJ574hCTg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e8rH6m2tqIXscgGJVPBrqw32QE9raXhxCraJexROyKIoMdF8OMxZ2OpC+rbuQP68jRvEH8fR0frh39Di9JTj7Ms4Erget9X/7eWf3W8vWGkPuWy2CcUADLXsH6PKJO+3L4rj/+tgRCFd+z28o/ThH6qOkJpukSLtBkpcYAALYxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ilXBkY/h; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-7ea7e2ff5ceso2628679a12.2;
        Sun, 27 Oct 2024 22:31:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730093503; x=1730698303; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xEQg2GoMuqIfSvIoQPeUZTxQLBpPTmz3yv4aNSrSx8I=;
        b=ilXBkY/hCe8C7Fpz6naFbaWxSH/gwpNPoYGWTlCCxBqlJI4meJyJh1qoK9sSbCOzjv
         U2lYIZxpRgTJ8nYCXjKB3rtV3UWw4Y+Jmq5rWU5mvZuruRASs51G+kpF97brZ3tDsfHX
         IQOg8zQ/ZoEPXjon78u1l8luaUIis6Z4STbwNBC2dvXVCeelKC6ZU4YoTPYvX8p7MnkJ
         M98Qmd7CW+PjG3iwFvLzcgBoMNSpYAN05gK8sDyAtsFxt+T0+TjrPTqB1QSBbEDMdEhP
         ukwp5rEjSUkRT7ghMWMy8xJxDHpE9RumVO3Q+vTTB12QzI8MlyP2wMfvdqCOopE0ssQL
         IwlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730093503; x=1730698303;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xEQg2GoMuqIfSvIoQPeUZTxQLBpPTmz3yv4aNSrSx8I=;
        b=hk4TPAOQlE6dcV/S0fa2pjldDebiOw/8Mr5XrT9cJWdN8LsBCD2THwW953k1vpUqsQ
         jlNUqpIcS9joFZh7LdE2Q1QBgGt2H0inzNg06+v81cVjqzLmrvzfVj0jl5CW+A2UaBt/
         mbAfvnzOMrqOXTS4Kb7g+zfwFTfrBoDYN9mLTqcbthW0s0vEmyEK4bkrplOmM2PKWaLp
         xEXQ81RhpqCHHFfbTMYBo4jUKGIT/5NSnPHFFGgs20pBNjzsnzYedQDz4hDRP9xt57kh
         nstHtuJrCCp/gi9PNkNgjggi0dlqFy6J5T+2SdcIBNdg6iVTAmM4Z7j/f2JI65L9fPm7
         U6jA==
X-Forwarded-Encrypted: i=1; AJvYcCWd34GXt459IydelywBNKFCtPJVPTyQGzuPbz+uQJS+kb0nPc1d0iT7vOHoy/vjH4JQauY3INTkQP4EeMU=@vger.kernel.org, AJvYcCXuYb16KJcc172GE6FoI1jhQvaHQhGyj9y/ORqUu2FFeit/N9M6ETqViky0FhfuO8WlQKy6k36tXjn7@vger.kernel.org
X-Gm-Message-State: AOJu0YwF9b9KpcUPvan5mmt0xgAdKzqWftyuKpj3gRiGj4PQ4N+wVrL6
	shBipHSDqdRgrf9Sqf1HU53pe11XD0sMfPQ2CfUExg6285UJrIlyDNO8pwA9FnI=
X-Google-Smtp-Source: AGHT+IGSIgLqaS9EfKl+irLis0mB+1g7+V3NTmH7i2LhfvWOB0rPfTqN7PSmEu+Fb2udknSnwC64ww==
X-Received: by 2002:a05:6a20:d806:b0:1d9:6f7f:7ad7 with SMTP id adf61e73a8af0-1d9a855f791mr8603381637.48.1730093502558;
        Sun, 27 Oct 2024 22:31:42 -0700 (PDT)
Received: from localhost.localdomain ([123.51.159.90])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e77e5769b9sm8157413a91.44.2024.10.27.22.31.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Oct 2024 22:31:42 -0700 (PDT)
From: Tony Chung <tony467913@gmail.com>
To: lkp@intel.com
Cc: gregkh@linuxfoundation.org,
	johan@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org,
	oe-kbuild-all@lists.linux.dev,
	tony467913@gmail.com
Subject: Re: [PATCH] usb: serial: mos7840: Fix coding style warnings 
Date: Mon, 28 Oct 2024 13:27:33 +0800
Message-ID: <20241028052732.4320-2-tony467913@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <202410251501.9hTgSYCH-lkp@intel.com>
References: <202410251501.9hTgSYCH-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I've sent the PATCH v2 which has fixed this build error. 
please check from the link below. Thanks.

https://lore.kernel.org/lkml/20241025061711.198933-1-tony467913@gmail.com/


Return-Path: <linux-kernel+bounces-391457-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BEFE9B876A
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 01:00:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DD41DB21D74
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 00:00:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67C7213211F;
	Fri,  1 Nov 2024 00:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="R56GkXfw"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0102E1E47A4
	for <linux-kernel@vger.kernel.org>; Fri,  1 Nov 2024 00:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730419206; cv=none; b=MQgl9l8C64s8TS2oVBUyEIVt5sA2Trnh/GmhiUtce+Fp1h6hBq2xgJEj4j1tzRYfgqxIYgBJOBVgZKOp6HY6pA3cpH0NGZ2wTgNeqWOnSnoKeSedKzwWX1X554/bg6DdH8+oMrTLglAuo1baJ9hYTj/gQKo9pCJY7UY5/nji/7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730419206; c=relaxed/simple;
	bh=dwDn0TURDpWQmYISsxqoCtZReaNWkDo/PboWB6G0Owk=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Kjlwvhr+7YErgzTDVOHrb7BnfBSdFykKipvXcBamKyEKdcnXAo4VQ/8+x7+LwTpKrjy8w7mv70fevZ+RaGFVwfMCkiXZWAu+WyIpBu4BQeTCsBzPqjA2Mg4MSi0VVFsD/UkTEqsG5ZEC4Fl4StfNx77P/HsU8ktQCw7A+rae5pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--amitsd.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=R56GkXfw; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--amitsd.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e297a366304so2490006276.2
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 17:00:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730419200; x=1731024000; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=cEt3MVqqxDBbCecmuXKd75lsXhmWRHU5J08RIUulB2g=;
        b=R56GkXfwinT9W16ByaGxSoECb/FeGethy5g0k1W96PZIrwQZfLH8H5+znGLkuiYM3J
         f1azHLTsdALoqPNyuhpknq7cnRPOqr0JQsCs+PU9SWgWqeKSzNA2NEB85VVtq/AHn7kS
         Fq4GK5L5rdXgSgXndkFCZNtNXBKZO8cvWqZv+DwpZ9rImdt2Tbk6YNv53OaW5qZ7ZtGs
         y5gPIUlBukw/LDivvCcNDB3/3qQ88EvW+hJDtAhI7A2g3gSurook4WosrntMNZ750yaa
         X2JmnFh9wsC3s7JL0TCfY59UqbW7facYJfTdS8g5zVq1qmkA9ArQRnMmMxYDyNF8typ3
         GooA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730419200; x=1731024000;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cEt3MVqqxDBbCecmuXKd75lsXhmWRHU5J08RIUulB2g=;
        b=nYQ1k0pueub692PBR7HX3bOtXo0Gm1wNiXqum6VAbKPtoXJcMyzJy2aFDu9mnURcin
         qLywCD8IO66RacvlgJeFYuDpU9LH32g2NdwGquEWRrXQAr6ojGD5xfJeGBcxVVwA3ZPB
         TXugBLEYBcoQqHkUnWHat4UFW8nFsL9OSNJsBcYJFdUSN6fbHqde0UB1PoT01qr9gxil
         xhjJHv5CQ8amQMIiDytzO2ufy7oKw7puUwSez2sSlQ4D2kN8VVM2yOXGaEG1d/X1Wf3A
         mfwQ4pC3NZlaiJgmui/baWe9zuoEWp67tzcVWrvSI3qwDpggEYLe225pl7akwXvI0yMf
         yy0Q==
X-Forwarded-Encrypted: i=1; AJvYcCUNZ8m7Cgelm1O9+eg9r450Uh/1553cxoz4Tv9jvw+++1ye8JMmEcaeUSyHDkaiU7/i1015HxPJ8EVkONM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTx5nYvZ4LbeMtQoM488D2TyCWaKkU7682gAtaUUnD3xtHS7c/
	GdyTSUknMXlkqbh82JTjDXsi5IJb1FSOXaVJ/fT2mTmKd4nPPzRjcwXIVGUL2U2hzQ/saE+H6BX
	3mw==
X-Google-Smtp-Source: AGHT+IEXZV3G3jh5U5saB7BhlzBPRlhCsxeQIBe08kK/8AySWU+uLXqwjkKqdarvd1ytRanLG3qi1O/CSHg=
X-Received: from amitsd-gti.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:827])
 (user=amitsd job=sendgmr) by 2002:a25:abc1:0:b0:e30:cee4:1431 with SMTP id
 3f1490d57ef6-e30cee41523mr14871276.1.1730419199960; Thu, 31 Oct 2024 16:59:59
 -0700 (PDT)
Date: Thu, 31 Oct 2024 16:59:51 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.199.ga7371fff76-goog
Message-ID: <20241031235957.1261244-1-amitsd@google.com>
Subject: [PATCH v1 0/3]  Add new time property for battery charger type detection
From: Amit Sunil Dhamne <amitsd@google.com>
To: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	gregkh@linuxfoundation.org, heikki.krogerus@linux.intel.com
Cc: dmitry.baryshkov@linaro.org, kyletso@google.com, rdbabiera@google.com, 
	badhri@google.com, linux@roeck-us.net, xu.yang_2@nxp.com, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-usb@vger.kernel.org, Amit Sunil Dhamne <amitsd@google.com>
Content-Type: text/plain; charset="UTF-8"

This patchset adds a new time DT property to handle time taken by
battery charger type detection completion.

Note that BC detection is based on
"Battery Charging Specification Revision 1.2".

This patchset depends on the patch series:
 - https://lore.kernel.org/all/20241022-pd-dt-time-props-v1-0-fea96f51b302@google.com/

Amit Sunil Dhamne (3):
  dt-bindings: connector: Add time property for Sink BC12 detection
    completion
  dt-bindings: usb: maxim,max33359.yaml: add usage of sink bc12 time
    property
  usb: typec: tcpm: Add support for sink-bc12-completion-time-ms DT
    property

 .../bindings/connector/usb-connector.yaml        | 11 +++++++++++
 .../devicetree/bindings/usb/maxim,max33359.yaml  |  1 +
 drivers/usb/typec/tcpm/tcpm.c                    | 16 +++++++++++++++-
 3 files changed, 27 insertions(+), 1 deletion(-)


base-commit: 0fc810ae3ae110f9e2fcccce80fc8c8d62f97907
prerequisite-patch-id: c08696694dabcbb86b458a935a9cbbcbabb75672
prerequisite-patch-id: 634924883df820956acb33941b659e8c9ef85d1e
-- 
2.47.0.199.ga7371fff76-goog



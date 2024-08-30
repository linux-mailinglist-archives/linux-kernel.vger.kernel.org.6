Return-Path: <linux-kernel+bounces-308041-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F38D0965674
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 06:38:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A99D61F242C6
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 04:38:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8392C166F06;
	Fri, 30 Aug 2024 04:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PaV4FV3z"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2780C15CD4D
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 04:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724992582; cv=none; b=PPGpGdExfFKk6eBIpvGexFevRtnHi7eGV2XHsgzA8R9PvozfzHqIq/AHxYRCTLSXHWNo6qd0cTSJVDRWAWb+Mlgriw3gYf8icziA9NQ0ki0vsqf94Fnaq5mtlVo+dHJffmVRR+Ke42GnH1h8+vQJr8nTFBIZYAxKkH5D9n/BXgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724992582; c=relaxed/simple;
	bh=HJ1J3DG8YKPkZK5xlFm3cde9CtJ0eqnDLgKsmATOB5g=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=XsjDNXKCCIdNna87iRLRiSQzzNJmRYD53tmlaRVMjl+/1iusOJPVDK93UMklMqIATY/ZIUUzCuReOKUIVYtxmE7qoO7jP+wbuLHJrZP27/j6Umalf5+xuAeflN0CcFcsvUWvVlPT8K46ShNMpihIafJzDuV0/TKqIvovip/NhN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PaV4FV3z; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-533461323cdso1686362e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 21:36:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724992578; x=1725597378; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HJ1J3DG8YKPkZK5xlFm3cde9CtJ0eqnDLgKsmATOB5g=;
        b=PaV4FV3zShLpKc1sY7rAk2clMEe1SndAP6zymMkEL+gQpvQ+exztgoQ5k8p3ltgwZt
         +97YqjB9dBvYXV9/xud+Zby9Rt4+6v8GjKhb7lZAeQAMgN7KHi0tQQTBv45IumpvXgOH
         T4OVi//z1TOxLK50lEb3XeaxUOJ/eK8K7cSVzhVRhwAplGdKIU5akkdvQUi/EnkCFYmx
         0Qhi4i/fUkJj3G6zlFoCygXR+RhW9LA8sl6JuMRFeXVDS11culYspiXQZqgEl9FY8Uk9
         s82xM2lh7lDX7tUj3Sz+KB7SoLMNzT4LMDjHyWgoouRzCYjrjBG9YLIvgFTbs9uSabAz
         fxtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724992578; x=1725597378;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HJ1J3DG8YKPkZK5xlFm3cde9CtJ0eqnDLgKsmATOB5g=;
        b=PKhDPFHySajFu+usDYH7J71ZE2iHa6MLuuROryHDe++yutbRHtdX0s1azzWww1kg37
         tcXaFqQ9DO3+p/LQ7mIQPLSOV6FFAyCTunaixKAk28HfbX3wN4qNIEezmWN8uG2kjNt1
         heXSvIJav7AO5a6O4Aomd7NI+iGXfVYpM/vo6uNWtjCaBMGIagGiclk54Mj9j+STIumn
         Ecr+t9UsUX14OPeEJLUkIclL57UlqE4qwovDmVZyNY547fRIErOcA7cGQcOeF7EsdP6+
         yA36cxoC9o4aEkL2RQH0oxg/VVf8UKDMytyru+Qm1QIKO1pn3A/DHTtgbD4/qBx1IqfE
         xVbg==
X-Gm-Message-State: AOJu0Yz4zpOqK9/gASi/3daRv6z39W/ojfPtC9GqixZW1McMlL+EK2We
	TSD+/Qnrpy2p8Z2pfuAeFTcjkWbaIkzRtXQSy4Qcw5qytLLHSG/cA1rTZAAS7d2WXfz9Mas9zBN
	bRPrFZd092IKqIFbpesAqxJ2JohVJR67K
X-Google-Smtp-Source: AGHT+IEwPtUF4qRSUJYoOB0nZtjA8uscO/MP+ti/GvD1TO9t6pYmrUuyBtlLoRqeoI1ZHAYuF9KzMVQa9Pksgbno7a0=
X-Received: by 2002:a05:6512:ad1:b0:52e:9f76:53dc with SMTP id
 2adb3069b0e04-53546a59f62mr500708e87.0.1724992577587; Thu, 29 Aug 2024
 21:36:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Lee Thomas Stephen <lee.iitb@gmail.com>
Date: Fri, 30 Aug 2024 10:05:38 +0530
Message-ID: <CAG7s96VLsbPoa5ihEu=b3kU51x3XSe24x5XkxMg8cQ2aYtJ22g@mail.gmail.com>
Subject: [Off Topic] Hello World
To: Linux Kernel Malining List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

It is great to see citizens of the world of many countries of many
races and genders collaborate without fear and in peace.
Problem Solving is one area that people here excel at.
What if they could do something about problems like violence between
and inside countries of the world?
Please think about it.

=E2=80=94
Lee


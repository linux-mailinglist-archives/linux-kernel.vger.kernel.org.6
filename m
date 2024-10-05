Return-Path: <linux-kernel+bounces-351912-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E58DD99178C
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Oct 2024 16:57:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8B75283009
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Oct 2024 14:57:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1D00154C14;
	Sat,  5 Oct 2024 14:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="ROVrgp8u"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81A8D155C82
	for <linux-kernel@vger.kernel.org>; Sat,  5 Oct 2024 14:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728140248; cv=none; b=e4E5zZiTq8+gLoJQuOp+eeB6Nk0Pa7wPo3B31j6Hkh+Z0oEv8k998N9aUV4El6tU6lK4UI8UfR3hafkOk8uQXz6Mi/UM2w/k+4xaBMjUtu2vybDBtIEUip7NStOjO5lz10jhK5RqOmXXpBZfMWDw6+Msg1tPgarAtBIP1dC58J0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728140248; c=relaxed/simple;
	bh=PNERBdSoYABjvLBTjHWqRLR9V7HfLgDklh4IEG5OIkU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pYlHnBfYnprn1kqN0e8Uw5Qn02tZhADe7R0wzSgfZv+gXGmsuNIfZPTijRGlHNtqm8yN2EH1D11707l33UAXR2+AFF5lqR15CxMG/VdVctTuFhqvgN3BCVhKJOjNWL8X5EDgwsc2BVxeKcmQRLDnplS6NWU6oVNXkZOdUB0/PDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=ROVrgp8u; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-71b8d10e9b3so2298702b3a.3
        for <linux-kernel@vger.kernel.org>; Sat, 05 Oct 2024 07:57:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1728140246; x=1728745046; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+9/J2RU6WiD/517i9NiTRedzi9Vk/ZZ6IN2HUrhWISE=;
        b=ROVrgp8uq+D3couLWZ4BLhvUITiri9EV5UnQMipfy0EweQplae6mtKvusel9dDpAd+
         FhVJsj+E2CC0B55XhAEmi69SqHsVHhhKVF+yd/5EIYwftLjRbeoiJ7x2gATWbB9d93SU
         gN0m3TDzZI7sGQUQNQIe/eRU1odU0fOiXUs2w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728140246; x=1728745046;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+9/J2RU6WiD/517i9NiTRedzi9Vk/ZZ6IN2HUrhWISE=;
        b=AsTqDgxiU4a5wPelDADUP3Rca2i3hoQ+0oBLcmlBz/gDYacElr/jxnwtCvGDEfaO16
         pLW+709kUIJqjPLeo+xWv6gpgYJwSzNTq5VHqn8seiEVhSMqHvJF/X8ZRGP7vazGIKbk
         /XN61k/7V6/5FgrfhXYrrRC2RbxMWTXOHWzQyLMuNoMjY6PdlKPWMydaqNWHcviLziC7
         CSggWdQ31H48o+tpOv7X6aTPNSbsdjfsbbY3UUwzZrexUH66n3SnieU8exZcNS9yDAjI
         FzUbePOeVyLaQJr5AiGCP91lhfAUA9tCMQyQVDMhkzPFX7DZtl1ee7IMC8Kto01ZyiPt
         KRdQ==
X-Forwarded-Encrypted: i=1; AJvYcCUTKFPdqU9veNbcRCAoIT2aCc+VGwDFioONiQzmMZH+eT0e2v1H5Zxyv6HiVrW8vLRfhTVXZGbPBwY+gV8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLGGyAC3in/x2KRSLcV1uH86CeTulGYFfmTHGeBUwEkxGtv/Rn
	zihw7xslTfgFRjqc4Ai31YfNsWqY1S5d2CuHufHUUMghjQdjikomZFiwjMhT8Vg=
X-Google-Smtp-Source: AGHT+IHBMDkW+v8Umw8Y1Iya1lux5xLD3qQMPWmOAH45zNaHnH9OUT2lHSTSdO1X0qTeK3Uot7V5Tw==
X-Received: by 2002:a05:6a00:3e1e:b0:71d:f2e3:a878 with SMTP id d2e1a72fcca58-71df2e3ab16mr3342278b3a.5.1728140245687;
        Sat, 05 Oct 2024 07:57:25 -0700 (PDT)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71df0d7d3b5sm1569273b3a.215.2024.10.05.07.57.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Oct 2024 07:57:25 -0700 (PDT)
From: Joe Damato <jdamato@fastly.com>
To: netdev@vger.kernel.org
Cc: Joe Damato <jdamato@fastly.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-kernel@vger.kernel.org (open list),
	Michael Chan <mchan@broadcom.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>
Subject: [RFC net-next v2 0/2] tg3: Link IRQs, NAPIs, and queues
Date: Sat,  5 Oct 2024 14:57:15 +0000
Message-Id: <20241005145717.302575-1-jdamato@fastly.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Greetings:

This RFC v3 follows from a previous RFC [1] submission which I noticed
had an issue in patch 2.

Patch 1 is changed to wrap a long line at 80 characters. No functional
changes. As such, I retained Pavan Chebbi's Reviewed-by.

Patch 2 in RFC v2 had an issue where it used the index into tp->irq_cnt
as the rxq or txq index; this is incorrect. It does not need seem that
tg3 assigns explicit queue index to struct tg3_napi, so the least
invasive change I could think of included two running counters in
tg3_napi_enable and tg3_napi_disable.

This is required because netif_queue_set_napi expected the queue index
(0 to real_num_[rt]x_queues) to be passed in to associate queues IDs
with NAPI IDs. tg2_napi_disable is modified in the reverse order;
counting down queue indices.

I am open to other suggestions on implementation from broadcom, but
thought that this was the least disruptive change.

I've tested this change on my tg3 hardware and it seems to work, see
commit message for examples of how to test.

Thanks,
Joe

[1]: https://lore.kernel.org/netdev/20240925162048.16208-1-jdamato@fastly.com/


Joe Damato (2):
  tg3: Link IRQs to NAPI instances
  tg3: Link queues to NAPIs

 drivers/net/ethernet/broadcom/tg3.c | 45 ++++++++++++++++++++++++-----
 1 file changed, 38 insertions(+), 7 deletions(-)

-- 
2.25.1



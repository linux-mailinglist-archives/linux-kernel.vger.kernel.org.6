Return-Path: <linux-kernel+bounces-329381-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B7CD979097
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Sep 2024 13:41:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65932284453
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Sep 2024 11:41:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D74D1CF280;
	Sat, 14 Sep 2024 11:41:53 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B337D13BC11
	for <linux-kernel@vger.kernel.org>; Sat, 14 Sep 2024 11:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726314113; cv=none; b=VxqErslE6UXckBBACLEMlfmPgljlHYN2RZUxoI1Tw3hcGrdyxd6kavnuF/Cx8SxguPOvIQjk5TtSBd292ykSS5oexQKqLxQmrb9jtW2eWlDImL1ck1S/i9HP/yMxic2X5vDSvC+MbBXpAgA8/Gw2RH1jk/aogzxePdEjzWbzcD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726314113; c=relaxed/simple;
	bh=T93E0/C0L+QtC/Ovq7SN42YdGhaYC3ZHIzShQpxZLqw=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=K/rDsOVlF1l34Z2ScA+p9XWleMoDbTZWDVTFS6T/qQKSn4wEk+UEFRYSf30oCNQP/KcDBX0VCl6YbjMHfgV6UrCQ/ReOIuc+TxfqWoVcLx7UQKIDyVXQlLU1O63WBC5dhk8owg9ikFj4NezHUruG37qirUL9kjdPNw9POOX3ZXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a08d90c938so44426665ab.1
        for <linux-kernel@vger.kernel.org>; Sat, 14 Sep 2024 04:41:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726314111; x=1726918911;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T93E0/C0L+QtC/Ovq7SN42YdGhaYC3ZHIzShQpxZLqw=;
        b=k3HxvQfLr3y58mmSg8M+jmtaYDTp1c9W5o7RpKc2W+ICeK/WhwoTPm8LRetaovWNtR
         zHqKGo+HjQz2zwIJ9b52oAdU/6O6g5wOBb9+SlaWlT6UEHPcvkIovSPx79q+RmS+DaOa
         tjVwVEzm25e63PNN1yR2CU0hckpt8J+3Nk7iA5K8I4gvnUxJANc1SxrMGt+nAzWofAdB
         LoJ1hxFnOxRvUxJBQIr6R4eJDvBYOLHYIKTIPdFU/Y/VsK0Nanz+Wtb5MW35c3Xovrqg
         db9nA3ALqVDJdbZRS69RN9k7lvNl+AW6ltwsQNPgjJraVu7VJy+LaSwhMoETVOS42Wrn
         H9aw==
X-Gm-Message-State: AOJu0Yyp9qjimb9zQXiOubSTBONPBYsYHlZnJfp+HTDIb7CAOJqKkuH+
	2h0YRGsnZd1ABveOG7O2A4WpedXxBER/nOJ4fS7TpkESkoFpw/QRe7mePR9hFiVsyOGfZyp0KU0
	Ck0XoWsE+Ao4w2w5fQOHepH4Zxk9aQN9Y2Fl1dQWLLNYufhSkHHAX3sg=
X-Google-Smtp-Source: AGHT+IG69Y9gn8t98FpR5K7btz6dd3qp9xrwgA2YrlSSPHBdxwefKCT0V93kGTMfg/eVDtl1z5tReQlasvwPfaijxDfjYvaRJDx4
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a68:b0:39f:5557:857f with SMTP id
 e9e14a558f8ab-3a084900bc8mr96193385ab.6.1726314110854; Sat, 14 Sep 2024
 04:41:50 -0700 (PDT)
Date: Sat, 14 Sep 2024 04:41:50 -0700
In-Reply-To: <000000000000c9af510621b0a773@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000593874062212d3a7@google.com>
Subject: Re: [syzbot] KMSAN: uninit-value in bch2_bkey_cmp_packed_inlined
From: syzbot <syzbot+6f655a60d3244d0c6718@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: KMSAN: uninit-value in bch2_bkey_cmp_packed_inlined
Author: pz010001011111@pm.me

#syz test


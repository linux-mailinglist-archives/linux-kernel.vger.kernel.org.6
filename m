Return-Path: <linux-kernel+bounces-397666-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6702B9BDEC7
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 07:23:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E8091F2472C
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 06:23:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8CD81922E5;
	Wed,  6 Nov 2024 06:23:02 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34FAA190676
	for <linux-kernel@vger.kernel.org>; Wed,  6 Nov 2024 06:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730874182; cv=none; b=FPzZaZiSKIr8zK2E5KbyVONwiiqZ0iVAslH/ArHvdMhLfDOPdN/DUc8ihhCXBYn4v9eAehhjv/ObrMw2kYYBNDwhA0HxWQsrMUmef7u/rbLEnWVkMQrMBQSLQ0FV4NAcpoZYhgdrsTwma7VLYWQY+YxGebP04bCk143MDAINstM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730874182; c=relaxed/simple;
	bh=t8a2/cCE1oflSLCaIQ27+8U51A0RiEFOLegdvq+mp8w=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=btV3Ck+V85DDZ0CPM0w2lSf6IG7BW4+JHREIjqYBt8SvZl19BT17NC7vRK9/3SzL+VitpRYmwyaXZIrZ8JhE/KUfGPJmOHoLFLmOMAi7GB+q7fqRpBDVJoarwpGwBGcscFeHrGg3BVbg0goW5ARHcdqXbZlCwFo9KT5/dS4iBEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a3c90919a2so70914345ab.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2024 22:23:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730874180; x=1731478980;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=t8a2/cCE1oflSLCaIQ27+8U51A0RiEFOLegdvq+mp8w=;
        b=rah8pzxUnGl7h1uIT61Hi0A9L8/fwwk/nAegA2ScxeckhJ7TH4q+xo1Ee049vLhJly
         XvNL7bD/lZy3HytDxdmzJicrkHhFlrffgyUvjsdLLM1Knyn24VPkHkVDhncjYGWlTQcR
         B5AgAyeCcgKN0iLFWhpPHlm/Jo1aggvS1uRjQ+Fh3e/hyTJm96Nvcckz5pVSpBL+HJnY
         4Jcmufr/PJ4yoRI1TbBpGWnKNelYk9xiNzoEjlt5ONneyvTDLUziUzEMjnZ225s7y1vQ
         oFopMsNR4ah1/e98koiAuy/AU0FijJ+aGSTC2TEkV+yEt/mYwmVpThFmPbkwqUFaEu+u
         hfNw==
X-Gm-Message-State: AOJu0Yy993mZYmfVJncFZgJu20A62ygSlZgALMeZli2vfYS6yoTWDOL7
	yOvgYAuTAxie+dw2uJKAHdV6fUX5FrbDcDPL+pYkqWnnZuDqIPTqO2ziwYowgRqSpY79/mG5fBO
	zkwyajZFjB1Vo9L/sAxnLqbcyP16Ns53zyrMV58mQRsTEcQy7SaJmHV4=
X-Google-Smtp-Source: AGHT+IEt+KLa4VHFP78QlHUasatm8xpsR9kMfvNYM9p4VQTSS1/oL0zPlcqA0X3cnDgOt9ULQKuleljsZMa37zuyXvW+7sAQYwTf
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:188d:b0:3a6:b360:c6e5 with SMTP id
 e9e14a558f8ab-3a6b360c89amr187198845ab.16.1730874180479; Tue, 05 Nov 2024
 22:23:00 -0800 (PST)
Date: Tue, 05 Nov 2024 22:23:00 -0800
In-Reply-To: <66fbc081.050a0220.6bad9.0056.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <672b0b44.050a0220.2a847.1b96.GAE@google.com>
Subject: Re: [syzbot] KMSAN: uninit-value in __hfs_ext_cache_extent (2) Inbox
From: syzbot <syzbot+d395b0c369e492a17530@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: KMSAN: uninit-value in __hfs_ext_cache_extent (2) Inbox
Author: sarvesh20123@gmail.com

#syz test


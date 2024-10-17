Return-Path: <linux-kernel+bounces-370732-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 484789A315D
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 01:29:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03CC028350D
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 23:29:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7775E200B95;
	Thu, 17 Oct 2024 23:29:19 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9E07200B87
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 23:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729207759; cv=none; b=sR+fY4uEZNqQSNHO7rt4+FIRumbhid7FNPdHBB46IamfUTNJrS0XEimWV7GhbWjdop9vsPDGXR1mBTZ/AHUi39NbSaeOGoZLSKgOoacUwarSf9/376inkjSxG1AySMxIq9WwY0Pl5rL53gFs9mYXXsvSG/E+8XUfbr1mnqideBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729207759; c=relaxed/simple;
	bh=wBPz+a+Q/5Yww+ofVxLgmiR2ANRgxXpfHCUS/40w9eg=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=lX9F2QpcWGI8XSHoZLlk0KzoV15HOzaCiFK+//Zsw4Fsnx4/NRizp8I8Q2dcfLd22hC4A7YhPkhUjIjSEmQ8Vzcilt0mIKfG9Jnwe+0zS9c7K9RrpUNW+tY0T6KYUzbJStKyRRVLjnj5rsKoeNSlPtnbq7EURFfnVL8udrdGKvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a1a8b992d3so19261005ab.0
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 16:29:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729207756; x=1729812556;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wBPz+a+Q/5Yww+ofVxLgmiR2ANRgxXpfHCUS/40w9eg=;
        b=GpPGFY+SZiHrJPeHMMxJcV0boZvErDNvSHuhOyjGg9h81bWiEnbIDLhMtzIaqJejTl
         CVzcybSsDUHy9j0EmHdceY0YBNUSGLQ/nFnaVrNb30V/0hLShOpntLPNL20sSHBWiJEh
         cVLw8sh9NBHLD/s7HnK+lCfCQ7VpKyjk4p0uVpTVqylOmcBx8X+VuasFtaLGWpIzaTbP
         d8W7lQ8iDxUab6vaQgh4nU54gjXRpX4Vu3rhgOQFU6UaxNYiGqIoislTXKwSG9TrOH6L
         vBh3YvpRFOCBf3j4BQo3UeTlfTCfY08rV+bhPKokJBGyLBaWM2H3Tjh4e4wcCIiQbp2J
         mUlw==
X-Gm-Message-State: AOJu0YzyE9X4PrXu2UCfy5Ax2dJZ5vjP1TfFzBJh0yX+iedLbCvAULRb
	j6/jkfxSvxJNFSs4Hm7KuzUa2X6oThmzs5Eji4ShKIGEbl/brCJpDbeAFr0vzlXc2pKolkKnJts
	8VbFqk7zbo0hoZmOV30Ntc+QoRtW3FO5ytEUpOW2TY7owPE0LK4HWF2o=
X-Google-Smtp-Source: AGHT+IEfnEgi9AbFDv2/UG1rAis8szc4Lf/flazP1gFx+zB4Pnp670YyyFgrLNz2BWwHAXA3+sA8RG/brKM5HxEWPjUZcWq3xliX
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:b26:b0:3a2:762b:faf0 with SMTP id
 e9e14a558f8ab-3a3f41ce346mr2586115ab.11.1729207755779; Thu, 17 Oct 2024
 16:29:15 -0700 (PDT)
Date: Thu, 17 Oct 2024 16:29:15 -0700
In-Reply-To: <66f057eb.050a0220.a27de.0004.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67119dcb.050a0220.10f4f4.0007.GAE@google.com>
Subject: Re: [syzbot] KMSAN: print len
From: syzbot <syzbot+346474e3bf0b26bd3090@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: KMSAN: print len
Author: danielyangkang@gmail.com

#syz test


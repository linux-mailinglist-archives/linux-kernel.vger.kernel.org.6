Return-Path: <linux-kernel+bounces-346861-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B37BD98C9E9
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 02:05:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C94001C23204
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 00:05:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFE51A23;
	Wed,  2 Oct 2024 00:05:28 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C6C77E1
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 00:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727827528; cv=none; b=AAfrgkFhAB1AoM7Sl2DdqwV/PKtGUZbziN/2+WVrLwKx3pqKJvp/dWkckXUpUpCn+kUTfjL8A8/wrnTuq5Bo2XZGyHgZrHqqjgqVrAFLLAS1lqa+bE7g2TgwPTkv6bk1DgTPJrhnCPUW+O80gks9GhwNSUmEg15kAoCqGSvgs6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727827528; c=relaxed/simple;
	bh=V7dhJZA4xaIJt9/+OO/eYeZ5NKxo1t8u3VwxydyxPwI=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=shseUUsELzew9vvWfxzOkM1PiwP5J+hTmFdha+lxLXwF4IhtSASZJCfwFPE0V4m+P5phU8QLVJ2HUA1w0oaOG3PuAL22KIMI8dsol+U4kMAsiNMA04mQMrcxiEnYgoN5EhbOMgQwR/yUVmbfGH+sIIL4EO+qXlrj1zlz0ofu7uU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a343c444afso62331595ab.1
        for <linux-kernel@vger.kernel.org>; Tue, 01 Oct 2024 17:05:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727827526; x=1728432326;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V7dhJZA4xaIJt9/+OO/eYeZ5NKxo1t8u3VwxydyxPwI=;
        b=Ep4jpHDVB+CPJqgOspqcU01slrt2Od7dfPX3Ci6HtSe1KENUflSlg2OEICte3InoFL
         cedwnoaaNddvXyd7xYZixaFsLMS0cR+sHhymXMkHrIWKidx2rCeK50Y+72rdiTLK4N9Y
         kC2fxTA/g1BMB27GEjW/BV66kq2i8UE9gmdgewttxw3qLhNylK5zLu8QmhKTAGhzb4i1
         gP69wAX39m83JBZlY9YiHVE0OuGayaIHK+f9nTMTjc1GcxjPbXN6jHUn8/t/rj6+OT6B
         qjA2Gi7WTL3cyERhWvnO/CttSbODiynaSfIWEqCv5DFGJQs5GEuo+pB1qMwFzVbYiYFM
         J4uA==
X-Gm-Message-State: AOJu0Yx4SdbWFHii25zng/U2FRayxCg0/7R0ezSDYItojboikscqth7f
	1RIFheJEAaS4KvFcY4TrK09YLzzvl+Kr5TSxYVC6pQWDwMLkCqY984zziIRC9RmkLZ7V8TyX8Y8
	M10QAvyCCWJWUCgdHhjo0S5/axZqbu0lr8aKxT0DidqtDOcBMg3E42uI=
X-Google-Smtp-Source: AGHT+IH6riB359Batq1V8YgSgNtR1bWtxtGBedqrYddDFLu08FbN23Sl+3LU0hXpkJUM9PcnPD1uLSG7uv2CWSXYcywXSX/th70q
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1568:b0:3a0:91fc:d0f8 with SMTP id
 e9e14a558f8ab-3a365942760mr10578145ab.12.1727827526195; Tue, 01 Oct 2024
 17:05:26 -0700 (PDT)
Date: Tue, 01 Oct 2024 17:05:26 -0700
In-Reply-To: <66f057eb.050a0220.a27de.0004.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66fc8e46.050a0220.f28ec.04dc.GAE@google.com>
Subject: Re: [syzbot] KMSAN
From: syzbot <syzbot+346474e3bf0b26bd3090@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: KMSAN
Author: danielyangkang@gmail.com

#syz test


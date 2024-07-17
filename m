Return-Path: <linux-kernel+bounces-254745-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 506D993371A
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 08:31:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C30A28322E
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 06:31:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 443B7182DF;
	Wed, 17 Jul 2024 06:31:28 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 882A61802E
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 06:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721197887; cv=none; b=F6/pMXPp0TCIrgbWPWAUiZnnzlBjQWUzzNGmqBvsQUUdaFdoHFhGRmieMtPMBaC6+73KMdTaJz5sFE5wsuu3BNe+CfLI/lsgaBTgSOILZQqndGBVXGGFSgHS09BGoFN2b1AjQ8i8dhtMVNqpEpg+Hy/ek2I59XfG/Vvv7AVwf8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721197887; c=relaxed/simple;
	bh=MCu6UmD9v5uNmIwUhKyPTDmC6j4OcDVNbkqVjtghaxM=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=TBiN6N2UVVgKHLCNRtaSUKjCXG1Af3vTmbbDsoTCGOdsRYJrPv1+FsSrjB9DOj26qFRcE6djv1iGcziHZWPmGf0zYqeQgGvDBpjwuKDM+Uyy8f9oTq9X7RCZACN1iwQ3PQaDVBdc+R85BHjH3k0Ak/zJZW3PvrvfOo5CZ4vFxbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7f682b4694aso81908139f.2
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 23:31:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721197886; x=1721802686;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MCu6UmD9v5uNmIwUhKyPTDmC6j4OcDVNbkqVjtghaxM=;
        b=ONfQqcGwRtyiItwd5q7WkoyLTSWNzEPwanuTnRTTr89RnNTDKJE6MlpGo97vHVGzoI
         ZZ7IZzZxlVhG/cwi0Kz8SZT4+c/L7u3/YEbGGCu/iDo/NHwt55TfasrB7Hg+oQPcCzbV
         FBOrVUtTQMWGcygDwZlO3uCVA78B3D+8si/9a2D+CU99AQrNj44bxjjn0hGMPyZPB9/S
         NiCcvBDNIkW0UokkzZTYxLqk8aEIA06XtmnoBwHw+PGGEjX3QhrWKyB+wlFfjNu07Xd9
         Q5TtGeG+l44A2dWxsHRHGM0j6M2PA+qx8oyVbHHC5qoQAbMo3kjDCG7au+n4yM2XuoeY
         T0MQ==
X-Gm-Message-State: AOJu0YyCrhXimuJb+NJ5xFBKngD3VqDADZMmGDDkPPnZ9snWqYVf+9b6
	fcYrUbOeY1EAD2GeQrq970H2SEvcdz2ZGPR6k/fLLjaSyrNSZTDuC6nkTAn5OHaWNlPg1o4pkYr
	o8n+6pyVPsK0wRRk6+EzuR7OJDa9nq5Pd2sWE1/cRiLJ9F2Zdmp01HmU=
X-Google-Smtp-Source: AGHT+IGEWDCBRvUGvX40ZLou7hgDd7h/Ea+2396IVgjVZaxZQkN85bRVktYVi+85SSV04UWUMyQQmMb3oQhVAFKS+aG7VGHqCMk5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:12c2:b0:4b9:6637:4909 with SMTP id
 8926c6da1cb9f-4c215d15f3emr27312173.6.1721197885810; Tue, 16 Jul 2024
 23:31:25 -0700 (PDT)
Date: Tue, 16 Jul 2024 23:31:25 -0700
In-Reply-To: <000000000000998cff06113e1d91@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009272e6061d6b9c27@google.com>
Subject: Re: [syzbot] ntfs3.git
From: syzbot <syzbot+c2ada45c23d98d646118@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: ntfs3.git
Author: almaz.alexandrovich@paragon-software.com

#syz test: https://github.com/Paragon-Software-Group/linux-ntfs3.git master






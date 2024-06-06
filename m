Return-Path: <linux-kernel+bounces-204156-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1114C8FE4E6
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 13:10:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A644E287213
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 11:10:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F3541953A4;
	Thu,  6 Jun 2024 11:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="Ywq89jY4"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D3AE17E443
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 11:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717672221; cv=none; b=gcS7ciM0AtsfuMf/LPhd7EIcRceAjChq0c1d2SyZuWmZ0hsYE6jsIlNszg31tf7vXjpXXlCjMcp0xIfwzlb92g/Y/IBy9RpoZphLygq8NRqIAIfYtxsYA6KYviYNxXigMcMvtvvtIhR9HZjYIsKOalW9ayrXxR5IBTY8YphpPk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717672221; c=relaxed/simple;
	bh=rKEbTCfYp0j2M89c2TXzm3ycbGwz3PSSgkyTb6IxAI8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a+HXjEFgeBPehdfKr6S2aGw0OGM1mLvNd+t7hOOevaEcuzIumy8qoY5olCmWPO3JgFyM8Dg1VVHOX7X1z3vso0iisKgPb2xHwRJF2PqjYusuKCjITXIw2vr9wREQb0D9jwgfsTIx5GQnJCQom/mtfjxyTQKUd5tYIIkMqEGnzUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=Ywq89jY4; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a69607c6ccaso86011866b.2
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2024 04:10:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1717672215; x=1718277015; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rKEbTCfYp0j2M89c2TXzm3ycbGwz3PSSgkyTb6IxAI8=;
        b=Ywq89jY4ESan3QWUa19aIcqPxHPKLdpAukDsSsPWksHangGmAn67ZTKokh0QXssai6
         z8ZrJzYH0UoH9IoA8Vnovor65d5hBfON9BRwd21+pVsSJgtX5MBv1+vNT1wgnHZ2wRCP
         y9ztb45iGh0PgElbhCFvHz8gcOpdzVBQuPUUo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717672215; x=1718277015;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rKEbTCfYp0j2M89c2TXzm3ycbGwz3PSSgkyTb6IxAI8=;
        b=UuYIVyrf7uSLcmGwlMgXNw1OblOK7NhFihGQeXzijbYwHC8nvzGzuCMnMqfUHEq6ZE
         rBTjU8isRItLQVaA3d0L8qNAT/Gi8u6NR+fjLGF38LB0hWaSrGdLbE/7gZm4KngQjEK4
         ejTv0faZjfz3MSwEOV0rrWP4Dx9bCyhwslqne+WB0pVzWWfQWb/UFPzeXEfCLLWxBcsQ
         Qtb900C1JtI7JOAoJ/UjHTCKPAoZIyK2F2B/A6OJLuH+WMOuM3JKKfZTXCLPZ6cbu/j6
         0W3USzzBFJkM0Iyo4s4ydMbWw0W7iRmkJbQZAnLqTANyGEiwSNbaFTmj+yUfHiuG6Sov
         /T7A==
X-Forwarded-Encrypted: i=1; AJvYcCWWr8cFJOkfkR4OCenAYRZlnb/8uuK1t/jGqWQQVLUwX0ODXYGS/Vogj64Dx8ywZ3MLituX5gjubIn+2y17ZlGS8v1k55Qc+9IAa+PN
X-Gm-Message-State: AOJu0YwgjkAISdn7pjRk5He9TpYgmRC5W19Kj7cyUbL8XilGJDHqnrz+
	0boNPVeQPlOcX+Ccw/N1Gy9YX2h+Mc9mBi1D+BRaB4t8JRCZTkl7M84Mk2uUs91qLjqEqj/FIR6
	JdjrzI6qyuWlvkhrpc9JX7dxms+UnW9UAsIyXgPxQuYhF8YlD/ik=
X-Google-Smtp-Source: AGHT+IGm0e86tHnJ7ewyM+gpz++EnmWLvK7sCcAhY7kwEQzDofLD+hRf1Kki/LQoR67pw9uJmopjsOBrGPC3K9mep4M=
X-Received: by 2002:a17:906:5846:b0:a6c:7181:500d with SMTP id
 a640c23a62f3a-a6c7181530amr190193166b.45.1717672215456; Thu, 06 Jun 2024
 04:10:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <000000000000c27c85061828ca26@google.com>
In-Reply-To: <000000000000c27c85061828ca26@google.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 6 Jun 2024 13:10:04 +0200
Message-ID: <CAJfpegutqoJxR303yk_8pkvGidEztteGhTpk2uhf-oC4AXdZRA@mail.gmail.com>
Subject: Re: [syzbot] [fuse?] WARNING in fuse_request_end
To: syzbot <syzbot+da4ed53f6a834e1bf57f@syzkaller.appspotmail.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
246014876d78


Return-Path: <linux-kernel+bounces-402389-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 506919C26FF
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 22:25:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 081811F22F40
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 21:25:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E81B1E0489;
	Fri,  8 Nov 2024 21:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OyyZPGAg"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 480381AA1EA
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 21:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731101152; cv=none; b=oUZNQjTE/gSOL/dBZ6LHljoS8ovS/JCFlsgf9p7RUc6k5rHj1C6/8rNCpz/+A2bwB5SSuiE2Bo+ajrESvqhZrVqVvCtRXdyN5s+955U7Z+QHBKg/LiHjkk+7NCaccbH+gJXdO3xhgGB2qZGnWSTjvhinvb2qPcOHpGtrcHm1SbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731101152; c=relaxed/simple;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=M8UvZlF3vKy62PuMmLwKrp+DxrwCi5/f4XJxqwPthiIJ1bbp20wWXgBburoxr5mo6yRJWTcQis3ypycz/AQgr11z6Feo7ZU6GVo2NafMIQED/yQBiJ15qDHoStixFB3IxbnV7Y2qrWr3nOQKcRa4qS1TUrnr0drbFvvNv5b+xvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OyyZPGAg; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-53a097aa3daso2548772e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2024 13:25:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731101148; x=1731705948; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
        b=OyyZPGAgYtsI0TzyUTzhOl5zt5o+TWeFxcJeQzJ1eQ/+SppIYJ67kYUbeYUsgFUWZ+
         IO6F3KHDNMOcM55iozYAqAB1BG1jtQh3xRrwUlqI4X1EbDDd+sqZAbCODq3bPmnjYs/M
         oMJ8MRUlrqJJgWPRisZmo8QKSF34ePoivLNRIY+BHioYGQ/i03ZJPROi6qy1myz9BZaK
         ZoYwmDXJEv46bPLGNa+9IdFjdwg1ft2n5ziSq+iqNQB6FlGSI+IOrc2hE7aY1/znARhk
         eWjJ7F4ed9hoXEsoEbchIHfyNAp3Y18YdGM2SatOWmJkE/1P5ThMLodI95qOwzhPuypY
         tmow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731101148; x=1731705948;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
        b=PIkNiRMA6sm/cHGqYzPdtTtpIyouPvwY32daF+tzDhxDqb1nUPPnCMLrfiM5UwxDfD
         xkySM45AsBNqEn6SaUSQ/bSQ2b2bCtJbwDCwzMywCfdzmqLHwZkPzXJKBpx4fNm/9cPa
         1g9uD6FyqkAVeWGuTFIw23CrlHPZU9gyh2CQx1sxl+t8tLB3eqIo9vZjGLmmQ08qBgyv
         7xshQVXTgNGmgTRnEi1CpM3IMp9JpeWwIxvMHQNJ0GxKFAZxCCOe4QVbcVjjmOR+hqWk
         nhWtzZ7ZmOuH8yWklMX20yXxEv/jRY0AIaE3MwYIFGSTglwQsdVY434sHRMQXxIbmqkV
         turA==
X-Gm-Message-State: AOJu0YxZYjICfTgeyfgep+bkFNZffp6vRcrPPLZkYMW9XMPGo0RvKCc9
	ePAVVbFk4qDBMH97ZG8ZXXNGc9sdJp2CnrVRJ7LxipoNYnKWRnPH86oRZrs7ciRa93yJXr+Wbax
	4Q2Beo53+Ot0i+1/aQWniAUbMJS8L2pOC
X-Google-Smtp-Source: AGHT+IH1ziDZWgHl/X0yfHx5iiVnqFIdc3bhGr+TEDK8VxG9af2FUzjxhiRg9CjRZ1yRlwpIfXIADlHxZPNFieKvxSo=
X-Received: by 2002:a05:6512:33c8:b0:539:d10b:e38b with SMTP id
 2adb3069b0e04-53d862e5fd6mr2353014e87.39.1731101148395; Fri, 08 Nov 2024
 13:25:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Shuxin Yang <shuxinyang.os@gmail.com>
Date: Fri, 8 Nov 2024 13:25:35 -0800
Message-ID: <CAC+_S0mcB0LJVUE5D7PT_RN0o=dOk8BSht=UWF5i64hNn8Lj5Q@mail.gmail.com>
Subject: unsubscribe
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"




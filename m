Return-Path: <linux-kernel+bounces-563760-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DD38A647CE
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 10:43:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D1FED18912B7
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 09:43:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E625221F3E;
	Mon, 17 Mar 2025 09:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NRBhWcIM"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82B85221540
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 09:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742204583; cv=none; b=HLihpDixuOeOKcDA54BHQ0GGHXkJddg0qTiOjnGtDeuzQ+cgCoNxUuIpEbtQQoA+dEisjakwbZKf5QvdHI6YzxzsiYXGw7iweMo6fcuZPzYe5XlEUESUKBvFowGmOf97vrl3H8T+OmC6kUDg60H7l46D/V9ZreWhm+0n6VXgR7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742204583; c=relaxed/simple;
	bh=fMvnQyVLLo9gBTux2YSUhBBhvQ6Z+QDadc4ETzE42OU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qbvjM3K4zGlEKFpKk5XURIL3KpUTDifK9mIiF9QGYid7BiCVd7+P+NG91adnhfRjCUBEQzuOuCCkjuR6V34x2nNWXpNRpzLhevFhcn5MGwznQUtx5kS3AB3echXBjfWAvyX2/r5yqtB79plzpWLHbUczJCvwaxKDwGPm7NK4q/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NRBhWcIM; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-43cf3192d8bso71055e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 02:43:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742204580; x=1742809380; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZNBXXqi4DBwxdKvdDXMfL/uGleeHnf81IxWIWHQGWzc=;
        b=NRBhWcIM6WFx89ylQNGpzlSrk3OTk2bTcqBRcmW7ZVCtW1GmbUatr4INgFpJmBOgfo
         8QfZa+sVIIYT4WtIQxz+jOCBxzBv0nuuuOsEkGh6shNRsEV0KeKG62M7ayqOyvV38hX7
         un13KtXO2I0stpBgd/MH4psRS9IUzmNI+SMOY8Swet8CWOoyAYVMA+kU754kMU5c4dPm
         eWrgtc30zKrIAhp0+Tdi4ABEEdz0LN+lkrviuvSduyt8/rAfxtZ0hfxDAr/bwAbWGrue
         4zUyZnkCs9izsoKM6wLeR1m2xVgLg2I0GiiDvvzztl7rj/0umkf7z7fXE2iIjWwtI7c7
         hVlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742204580; x=1742809380;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZNBXXqi4DBwxdKvdDXMfL/uGleeHnf81IxWIWHQGWzc=;
        b=OXoYTYKRXWhQNveeZ7NUBX1zWPYr3R22+OFxZ4b22VAQ4FL7s8tU68oyWmWM0rLDqi
         px9QE05yA5PdC1VVNYuWpIeVS0BaTygWhXVpjWpGlv0w1n7XEunVKHtj8FiVFkpWzVa9
         F7i7NjXa0KW4KprXbQCljhk0vkwHNNzt1GmhxQqn6crSI8WKipFuaY5p4NcSjpGpEovk
         muhA4LpI5OATk2nVjZtQxVY7tg0NHYfmFRjsWBY/rHSIl9SzI+pTPGatg5BIIlUzUJXG
         kyUNqnYdFoygZWORz8pQv+43QxlKdAZNkdRlKjd7cN/Pf1t5eXopRByss89Nw6P3b+tP
         8AvA==
X-Forwarded-Encrypted: i=1; AJvYcCVuZ4Ndm5ckv3ICCXdws8zoYnDNxPOSO8WW+/+fH/lDE4UX6KhTsbLNX9s8GYaWGrpkjd4QGBbXVBHrcwo=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywr5crbxvVMngnAHDRKPtO6D7/KxxYzfPQz/bBKbHSGfSlacuHy
	L+tFSNt1jVifJT8OJ9KAADRfeWUH3FA2JcfduidD+uO9nZKGPP5LvHESh6Ww5+qZRZl3bT2+kR4
	6Mg==
X-Gm-Gg: ASbGncupVmmF8/dd8MWUIsRf29GkYYCC7TFch0cr0SZygC5P8cs5ANV8hKt6Kq95zBl
	N6kBQXD7zVXws/Rp/7o+xedRgJ2gR2FLoScHDwOESOS+U4oTP4fllWGWwtFSkT5hAv33CFW+ndH
	H432wk01JmvtT9WIx0TbzaXnLb/W/jczd6ki8o9d8DE95ugLaeqreic5KQaMw3fTpsob8xeOR8Y
	p+ykk5PTyKituhYLUOphLu/zAtxmDiQfsAycLNqqFH63zMpCRZsEV7ZV9wXaamH8DousckRYQxW
	rMmOf5FEKV9e5lT+W6cw3/l1WEbBS0yP791J+iVEj9bfnyBv01vMwZ2nMdFtERYbm3H1wmSFMN0
	am+GlFgk=
X-Google-Smtp-Source: AGHT+IEcdEN6HERz3J0WioxLPvUL69iwpVs4Tbq3dNt5h5y9rEuhL/oEbqy2OeOgd8oRjQk7FdECCQ==
X-Received: by 2002:a05:600c:6d07:b0:43b:b106:bb1c with SMTP id 5b1f17b1804b1-43d2518e332mr2391635e9.0.1742204579754;
        Mon, 17 Mar 2025 02:42:59 -0700 (PDT)
Received: from google.com (158.100.79.34.bc.googleusercontent.com. [34.79.100.158])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395cbbc88f2sm14421275f8f.101.2025.03.17.02.42.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Mar 2025 02:42:59 -0700 (PDT)
Date: Mon, 17 Mar 2025 09:42:55 +0000
From: Brendan Jackman <jackmanb@google.com>
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Nathan Chancellor <nathan@kernel.org>
Subject: Re: [PATCH 11/13] objtool: Change "warning:" to "error:" for --Werror
Message-ID: <Z9fun5FkOVps8Yt7@google.com>
References: <cover.1741975349.git.jpoimboe@kernel.org>
 <56f0565b15b4b4caa9a08953fa9c679dfa973514.1741975349.git.jpoimboe@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <56f0565b15b4b4caa9a08953fa9c679dfa973514.1741975349.git.jpoimboe@kernel.org>

On Fri, Mar 14, 2025 at 12:29:09PM -0700, Josh Poimboeuf wrote:
> This is similar to GCC's behavior and makes it more obvious why the
> build failed.
> 
> Suggested-by: Nathan Chancellor <nathan@kernel.org>
> Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>

Reviewed-by: Brendan Jackman <jackmanb@google.com>


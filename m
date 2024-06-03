Return-Path: <linux-kernel+bounces-198944-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BFEB18D7F89
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 11:59:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 74A201F22D1D
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 09:59:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91EF478C80;
	Mon,  3 Jun 2024 09:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PVcPdCxU"
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E5783BBE0
	for <linux-kernel@vger.kernel.org>; Mon,  3 Jun 2024 09:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717408768; cv=none; b=MCit3nfedrMO8nfhsNIG/m/dOn8HusECHoYSN7wTN9ub0sOknKgm8rfnvdEz4wzlywARRYPJeY80gKzK+/z7vjj9Iabbp0HbX9zTSJnd3oZ+Pq9qV57gJTsUpSdfMI7+7V0ea9t9H7UrXPUfIde02Ea/55E3Gei7m3+PPsgN0Tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717408768; c=relaxed/simple;
	bh=v2qggc06k2Ik2oWf1uy6ygtLfVG2TeaA3b5m26KyzrM=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=AazKWFZxsV1KLUcCLGvx/GWWl4e5NILLDPE7h1uoTMhpQGwRhWh7nERbeEwZbIgLaEVjWLXvWVjxDDqj2YIxQ1rrfyzDT7wlNfvhC1Fb8MRnW+r18fb4G79BBW1cyPpoMVNrAnRe9iK64BvbnKeBRhx9Yb7ujq32Ohu5Qhf+TJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=PVcPdCxU; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-62a2424ecdaso40553857b3.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jun 2024 02:59:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717408766; x=1718013566; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=2sf6/Ux2VYi7nFYLYZrQyNItvHWfx+3Ypo44+bhHobA=;
        b=PVcPdCxUBJ2QFoDyWH05sbyBZgP2H/TzlYGnrUEreWgMSRNmekxkBQyBkM3GNTxIxs
         HUOW3prPn9LZ1goH9kvZ/RFFoqGKLeo0hSr9VWU6bhgGa8RcTSRbbHFbGwYAupkhUp5h
         3siW2NY6qzUdwpiP6l+bGtWqvVyeRMQkm5pEtlq4qqmdn7AC0Jgj7MzGPZMqIocvgkqK
         OjSMs5ZHWiWsUo/0qwbglPo+I9aq0ul5FNn9nQOTYYnLWDrOf3y1F/LM6jkGxGaSnDu2
         ztKvI4dWUpffOKIJZKhdbFnIhFzkPDt6dag/rK+r4jyfaHiwi2CGwBW5pGgHH7hNsMwp
         n2Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717408766; x=1718013566;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2sf6/Ux2VYi7nFYLYZrQyNItvHWfx+3Ypo44+bhHobA=;
        b=msdTmdJPPZE58LMj7u0X93xZ68GnQAH4cd//ZC2Fgg2d9Z/rvwBTYJxdiXwDPEwjbk
         xJaW5sehKTkDcygURI+F3ROKBDFQVLhItEOdjqrCXNSxsrzfB187QWlTAm9+NzbVqlq+
         0lMHvWrvB6uaDwtZPuZeuRnyBrlhVJVc7VR5DU3/pgs83czUYYg5s0C63nWH32R49u5X
         o6nC8mcaQ3Uw2hBoWHQCYrM6WUkJQJqxo+E5KKAwP7L/XULoieF3gnfD97ihjMXbHlkk
         UIOsHdta/ldZ5lbppPi0HuDRbiGBxMrnifkmh8p/TdKTntma1xv6BPqglqYV24aFy0T5
         9JKQ==
X-Forwarded-Encrypted: i=1; AJvYcCWJEjlwTlYs8aTPw9+rcjA+qisaJHI7AIWI8rKuO79fEapWSzaAsw1kg5g7g43J40G0h2E4OMaru3eOQgbxfoUOHS/gRXizdujEBEum
X-Gm-Message-State: AOJu0Yzowl530b8f/w1Sqx/2XIi+IN5YIrovfalATKghuWZIRqHeEAfV
	ezyAw4DUfPiGcifr+DbzVvvtJrwuLzRyJ4QGJeh/zsRLqiXTU8ANmwX2MgHeTFST7wjupXybwWj
	w5qujRzoCKgVIaG+cIw3LGU+TNvgDmQPPSFMJ4Q==
X-Google-Smtp-Source: AGHT+IE7NNI+KSNyP7SOvaVmEddSRd4UoGZAjUxolk37jgs1wmRtPxElbc4dgzjjR7mKAbemO6WfBW0hrdblwEckUw4=
X-Received: by 2002:a25:d682:0:b0:df7:c087:5787 with SMTP id
 3f1490d57ef6-dfa73bf3181mr8335000276.19.1717408766245; Mon, 03 Jun 2024
 02:59:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Terry Tritton <terry.tritton@linaro.org>
Date: Mon, 3 Jun 2024 10:59:15 +0100
Message-ID: <CABeuJB1RP8wty0AObsmw+FCWMNyAmrutL-ZXy9ZwnZ8oK1iGSg@mail.gmail.com>
Subject: Change in splice() behaviour after 5.10?
To: hch@lst.de
Cc: "ttritton@google.com" <ttritton@google.com>, edliaw@google.com, keescook@chromium.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi,
We've found a change in behaviour while testing the splice07 LTP test.
In versions before 5.10 the test will hang on certain combinations but after
5.10 the splice call will return.
I bisected the change to the following commit:
    36e2c7421f02a22f71c9283e55fdb672a9eb58e7
    fs: don't allow splice read/write without explicit ops

There has been some discussion on the LTP github page already:
    https://github.com/linux-test-project/ltp/issues/1156

From the github link these combinations fail on 5.4:
|in_fd            |  out_fd            |  error  |
--------------------------------------------------
|TST_FD_PIPE_READ |  TST_FD_EPOLL      | hangs   |
|TST_FD_PIPE_READ |  TST_FD_EVENTFD    | hangs   |
|TST_FD_PIPE_READ |  TST_FD_SIGNALFD   | hangs   |
|TST_FD_PIPE_READ |  TST_FD_TIMERFD    | hangs   |
|TST_FD_PIPE_READ |  TST_FD_PIDFD      | hangs   |
|TST_FD_PIPE_READ |  TST_FD_PERF_EVENT | hangs   |
|TST_FD_PIPE_READ |  TST_FD_IO_URING   | hangs   |
|TST_FD_PIPE_READ |  TST_FD_BPF_MAP    | hangs   |
|TST_FD_PIPE_READ |  TST_FD_FSOPEN     | hangs   |
|TST_FD_PIPE_READ |  TST_FD_FSPICK     | hangs   |
|TST_FD_INOTIFY   |  TST_FD_PIPE_WRITE | hangs   |
|TST_FD_DIR       |  TST_FD_PIPE_WRITE | EISDIR  |
|TST_FD_PERF_EVENT| TST_FD_PIPE_WRITE | ENODATA |
|TST_FD_FSOPEN    |  TST_FD_PIPE_WRITE | ENODATA |
|TST_FD_FSPICK    |  TST_FD_PIPE_WRITE | ENODATA |


PoC below, this program will hang before 36e2c7421f and complete after it.

#define _GNU_SOURCE
#include <fcntl.h>
#include <stdio.h>
#include <sys/epoll.h>
#include <unistd.h>

int main(){
    int fd_in[2];
    int fd_out;

    pipe(fd_in);
    fd_out = epoll_create(1);

    splice(fd_in[0], NULL, fd_out, NULL, 1, 0);

    printf("Should not hang!\n");

    return 0;
}

Is this change expected?


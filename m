Return-Path: <linux-kernel+bounces-560947-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A813A60B56
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 09:26:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 639453AC96A
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 08:26:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D0C91A5B81;
	Fri, 14 Mar 2025 08:26:19 +0000 (UTC)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 269081A5BB0;
	Fri, 14 Mar 2025 08:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741940778; cv=none; b=apoDKOAzn0vQH+K+WT+9r14QEq+Lee/dGR/25Dc7q2DYGaAnHLSPhW9pUbXWrfVjmzASLQ54brpLxXDTgHLcUqevlYt6lyfVOUbQCDAUif7AEBTHhsaR92OWEI1D9CJqd3fgiS/HXNCrsCi7hBCesUO1DvIumLHaYE6HS9QEPtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741940778; c=relaxed/simple;
	bh=bTHkDdG1/ll+vAWoQvMLtvN4uKwaToI7IsZcR0gjJZs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=TInpw0Pt5kn+Jc+US0eovLOdO24t/Ne3+jKn+XmU8GY2tKGgWzZVXssDI+BKXU7fSU+DGrd6pBS6TSzrxEPeO9c9987U2H2euho9flNYXgJTyztTih9uFDyPqfL+YHVpiXxBGD21keFhdN+9DsCCEHjG3uDPbvIoFt1u9h4yT4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4ZDcq06Lzvz1R6Zp;
	Fri, 14 Mar 2025 16:24:28 +0800 (CST)
Received: from dggemv712-chm.china.huawei.com (unknown [10.1.198.32])
	by mail.maildlp.com (Postfix) with ESMTPS id DD7641A016C;
	Fri, 14 Mar 2025 16:26:10 +0800 (CST)
Received: from kwepemn100009.china.huawei.com (7.202.194.112) by
 dggemv712-chm.china.huawei.com (10.1.198.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 14 Mar 2025 16:26:10 +0800
Received: from localhost.localdomain (10.90.30.45) by
 kwepemn100009.china.huawei.com (7.202.194.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 14 Mar 2025 16:26:10 +0800
From: Huisong Li <lihuisong@huawei.com>
To: <linux@roeck-us.net>, <jdelvare@suse.com>
CC: <linux-hwmon@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<zhanjie9@hisilicon.com>, <zhenglifeng1@huawei.com>,
	<liuyonglong@huawei.com>, <lihuisong@huawei.com>
Subject: [PATCH v2] hwmon: (acpi_power_meter) Replace the deprecated hwmon_device_register
Date: Fri, 14 Mar 2025 16:18:34 +0800
Message-ID: <20250314081834.3243243-1-lihuisong@huawei.com>
X-Mailer: git-send-email 2.30.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemn100009.china.huawei.com (7.202.194.112)

When load this mode, we can see the following log:
"power_meter ACPI000D:00: hwmon_device_register() is deprecated. Please
 convert the driver to use hwmon_device_register_with_info()."

So replace hwmon_device_register with hwmon_device_register_with_info.

These attributes, 'power_accuracy', 'power_cap_hyst', 'power_average_min'
and 'power_average_max', should have been placed in hwmon_chip_info as
power data type. But these attributes are displayed as string format on
the following case:
a) power1_accuracy  --> display like '90.0%'
b) power1_cap_hyst  --> display 'unknown' when its value is 0xFFFFFFFF
c) power1_average_min/max --> display 'unknown' when its value is
			      negative.
To avoid any changes in the display of these sysfs interfaces, we can't
modifiy the type of these attributes in hwmon core and have to put them
to extra_groups.

Please note that the path of these sysfs interfaces are modified
accordingly if use hwmon_device_register_with_info():
old: all sysfs interfaces are under acpi device, namely,
     /sys/class/hwmon/hwmonX/device/
now: all sysfs interfaces are under hwmon device, namely,
     /sys/class/hwmon/hwmonX/
The new ABI does not guarantee that the underlying path remains the same.
But we have to accept this change so as to replace the deprecated API.
Fortunately, some userspace application, like libsensors, would scan
the two path and handles this automatically. So to drop the deprecated
message, we can accept this change.

Signed-off-by: Huisong Li <lihuisong@huawei.com>
---
 drivers/hwmon/acpi_power_meter.c | 861 +++++++++++++++----------------
 1 file changed, 427 insertions(+), 434 deletions(-)

diff --git a/drivers/hwmon/acpi_power_meter.c b/drivers/hwmon/acpi_power_meter.c
index f05986e4f379..46e8a0b6b210 100644
--- a/drivers/hwmon/acpi_power_meter.c
+++ b/drivers/hwmon/acpi_power_meter.c
@@ -87,25 +87,14 @@ struct acpi_power_meter_resource {
 	bool		power_alarm;
 	int			sensors_valid;
 	unsigned long		sensors_last_updated;
-	struct sensor_device_attribute	sensors[NUM_SENSORS];
-	int			num_sensors;
+#define POWER_METER_TRIP_AVERAGE_MIN_IDX	0
+#define POWER_METER_TRIP_AVERAGE_MAX_IDX	1
 	s64			trip[2];
 	int			num_domain_devices;
 	struct acpi_device	**domain_devices;
 	struct kobject		*holders_dir;
 };
 
-struct sensor_template {
-	char *label;
-	ssize_t (*show)(struct device *dev,
-			struct device_attribute *devattr,
-			char *buf);
-	ssize_t (*set)(struct device *dev,
-		       struct device_attribute *devattr,
-		       const char *buf, size_t count);
-	int index;
-};
-
 /* Averaging interval */
 static int update_avg_interval(struct acpi_power_meter_resource *resource)
 {
@@ -124,62 +113,6 @@ static int update_avg_interval(struct acpi_power_meter_resource *resource)
 	return 0;
 }
 
-static ssize_t show_avg_interval(struct device *dev,
-				 struct device_attribute *devattr,
-				 char *buf)
-{
-	struct acpi_device *acpi_dev = to_acpi_device(dev);
-	struct acpi_power_meter_resource *resource = acpi_dev->driver_data;
-
-	mutex_lock(&resource->lock);
-	update_avg_interval(resource);
-	mutex_unlock(&resource->lock);
-
-	return sprintf(buf, "%llu\n", resource->avg_interval);
-}
-
-static ssize_t set_avg_interval(struct device *dev,
-				struct device_attribute *devattr,
-				const char *buf, size_t count)
-{
-	struct acpi_device *acpi_dev = to_acpi_device(dev);
-	struct acpi_power_meter_resource *resource = acpi_dev->driver_data;
-	union acpi_object arg0 = { ACPI_TYPE_INTEGER };
-	struct acpi_object_list args = { 1, &arg0 };
-	int res;
-	unsigned long temp;
-	unsigned long long data;
-	acpi_status status;
-
-	res = kstrtoul(buf, 10, &temp);
-	if (res)
-		return res;
-
-	if (temp > resource->caps.max_avg_interval ||
-	    temp < resource->caps.min_avg_interval)
-		return -EINVAL;
-	arg0.integer.value = temp;
-
-	mutex_lock(&resource->lock);
-	status = acpi_evaluate_integer(resource->acpi_dev->handle, "_PAI",
-				       &args, &data);
-	if (ACPI_SUCCESS(status))
-		resource->avg_interval = temp;
-	mutex_unlock(&resource->lock);
-
-	if (ACPI_FAILURE(status)) {
-		acpi_evaluation_failure_warn(resource->acpi_dev->handle, "_PAI",
-					     status);
-		return -EINVAL;
-	}
-
-	/* _PAI returns 0 on success, nonzero otherwise */
-	if (data)
-		return -EINVAL;
-
-	return count;
-}
-
 /* Cap functions */
 static int update_cap(struct acpi_power_meter_resource *resource)
 {
@@ -198,61 +131,6 @@ static int update_cap(struct acpi_power_meter_resource *resource)
 	return 0;
 }
 
-static ssize_t show_cap(struct device *dev,
-			struct device_attribute *devattr,
-			char *buf)
-{
-	struct acpi_device *acpi_dev = to_acpi_device(dev);
-	struct acpi_power_meter_resource *resource = acpi_dev->driver_data;
-
-	mutex_lock(&resource->lock);
-	update_cap(resource);
-	mutex_unlock(&resource->lock);
-
-	return sprintf(buf, "%llu\n", resource->cap * 1000);
-}
-
-static ssize_t set_cap(struct device *dev, struct device_attribute *devattr,
-		       const char *buf, size_t count)
-{
-	struct acpi_device *acpi_dev = to_acpi_device(dev);
-	struct acpi_power_meter_resource *resource = acpi_dev->driver_data;
-	union acpi_object arg0 = { ACPI_TYPE_INTEGER };
-	struct acpi_object_list args = { 1, &arg0 };
-	int res;
-	unsigned long temp;
-	unsigned long long data;
-	acpi_status status;
-
-	res = kstrtoul(buf, 10, &temp);
-	if (res)
-		return res;
-
-	temp = DIV_ROUND_CLOSEST(temp, 1000);
-	if (temp > resource->caps.max_cap || temp < resource->caps.min_cap)
-		return -EINVAL;
-	arg0.integer.value = temp;
-
-	mutex_lock(&resource->lock);
-	status = acpi_evaluate_integer(resource->acpi_dev->handle, "_SHL",
-				       &args, &data);
-	if (ACPI_SUCCESS(status))
-		resource->cap = temp;
-	mutex_unlock(&resource->lock);
-
-	if (ACPI_FAILURE(status)) {
-		acpi_evaluation_failure_warn(resource->acpi_dev->handle, "_SHL",
-					     status);
-		return -EINVAL;
-	}
-
-	/* _SHL returns 0 on success, nonzero otherwise */
-	if (data)
-		return -EINVAL;
-
-	return count;
-}
-
 /* Power meter trip points */
 static int set_acpi_trip(struct acpi_power_meter_resource *resource)
 {
@@ -287,34 +165,6 @@ static int set_acpi_trip(struct acpi_power_meter_resource *resource)
 	return 0;
 }
 
-static ssize_t set_trip(struct device *dev, struct device_attribute *devattr,
-			const char *buf, size_t count)
-{
-	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
-	struct acpi_device *acpi_dev = to_acpi_device(dev);
-	struct acpi_power_meter_resource *resource = acpi_dev->driver_data;
-	unsigned long temp, trip_bk;
-	int res;
-
-	res = kstrtoul(buf, 10, &temp);
-	if (res)
-		return res;
-
-	temp = DIV_ROUND_CLOSEST(temp, 1000);
-
-	guard(mutex)(&resource->lock);
-
-	trip_bk = resource->trip[attr->index - 7];
-	resource->trip[attr->index - 7] = temp;
-	res = set_acpi_trip(resource);
-	if (res) {
-		resource->trip[attr->index - 7] = trip_bk;
-		return res;
-	}
-
-	return count;
-}
-
 /* Power meter */
 static int update_meter(struct acpi_power_meter_resource *resource)
 {
@@ -341,206 +191,6 @@ static int update_meter(struct acpi_power_meter_resource *resource)
 	return 0;
 }
 
-static ssize_t show_power(struct device *dev,
-			  struct device_attribute *devattr,
-			  char *buf)
-{
-	struct acpi_device *acpi_dev = to_acpi_device(dev);
-	struct acpi_power_meter_resource *resource = acpi_dev->driver_data;
-
-	mutex_lock(&resource->lock);
-	update_meter(resource);
-	mutex_unlock(&resource->lock);
-
-	if (resource->power == UNKNOWN_POWER)
-		return -ENODATA;
-
-	return sprintf(buf, "%llu\n", resource->power * 1000);
-}
-
-/* Miscellaneous */
-static ssize_t show_str(struct device *dev,
-			struct device_attribute *devattr,
-			char *buf)
-{
-	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
-	struct acpi_device *acpi_dev = to_acpi_device(dev);
-	struct acpi_power_meter_resource *resource = acpi_dev->driver_data;
-	acpi_string val;
-	int ret;
-
-	mutex_lock(&resource->lock);
-	switch (attr->index) {
-	case 0:
-		val = resource->model_number;
-		break;
-	case 1:
-		val = resource->serial_number;
-		break;
-	case 2:
-		val = resource->oem_info;
-		break;
-	default:
-		WARN(1, "Implementation error: unexpected attribute index %d\n",
-		     attr->index);
-		val = "";
-		break;
-	}
-	ret = sprintf(buf, "%s\n", val);
-	mutex_unlock(&resource->lock);
-	return ret;
-}
-
-static ssize_t show_val(struct device *dev,
-			struct device_attribute *devattr,
-			char *buf)
-{
-	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
-	struct acpi_device *acpi_dev = to_acpi_device(dev);
-	struct acpi_power_meter_resource *resource = acpi_dev->driver_data;
-	u64 val = 0;
-	int ret;
-
-	guard(mutex)(&resource->lock);
-
-	switch (attr->index) {
-	case 0:
-		val = resource->caps.min_avg_interval;
-		break;
-	case 1:
-		val = resource->caps.max_avg_interval;
-		break;
-	case 2:
-		val = resource->caps.min_cap * 1000;
-		break;
-	case 3:
-		val = resource->caps.max_cap * 1000;
-		break;
-	case 4:
-		if (resource->caps.hysteresis == UNKNOWN_HYSTERESIS)
-			return sprintf(buf, "unknown\n");
-
-		val = resource->caps.hysteresis * 1000;
-		break;
-	case 5:
-		if (resource->caps.flags & POWER_METER_IS_BATTERY)
-			val = 1;
-		else
-			val = 0;
-		break;
-	case 6:
-		ret = update_meter(resource);
-		if (ret)
-			return ret;
-		/* need to update cap if not to support the notification. */
-		if (!(resource->caps.flags & POWER_METER_CAN_NOTIFY)) {
-			ret = update_cap(resource);
-			if (ret)
-				return ret;
-			resource->power_alarm = resource->power > resource->cap;
-			val = resource->power_alarm;
-		} else {
-			val = resource->power_alarm ||
-				 resource->power > resource->cap;
-			resource->power_alarm = resource->power > resource->cap;
-		}
-		break;
-	case 7:
-	case 8:
-		if (resource->trip[attr->index - 7] < 0)
-			return sprintf(buf, "unknown\n");
-
-		val = resource->trip[attr->index - 7] * 1000;
-		break;
-	default:
-		WARN(1, "Implementation error: unexpected attribute index %d\n",
-		     attr->index);
-		break;
-	}
-
-	return sprintf(buf, "%llu\n", val);
-}
-
-static ssize_t show_accuracy(struct device *dev,
-			     struct device_attribute *devattr,
-			     char *buf)
-{
-	struct acpi_device *acpi_dev = to_acpi_device(dev);
-	struct acpi_power_meter_resource *resource = acpi_dev->driver_data;
-	unsigned int acc = resource->caps.accuracy;
-
-	return sprintf(buf, "%u.%u%%\n", acc / 1000, acc % 1000);
-}
-
-static ssize_t show_name(struct device *dev,
-			 struct device_attribute *devattr,
-			 char *buf)
-{
-	return sprintf(buf, "%s\n", ACPI_POWER_METER_NAME);
-}
-
-#define RO_SENSOR_TEMPLATE(_label, _show, _index)	\
-	{						\
-		.label = _label,			\
-		.show  = _show,				\
-		.index = _index,			\
-	}
-
-#define RW_SENSOR_TEMPLATE(_label, _show, _set, _index)	\
-	{						\
-		.label = _label,			\
-		.show  = _show,				\
-		.set   = _set,				\
-		.index = _index,			\
-	}
-
-/* Sensor descriptions.  If you add a sensor, update NUM_SENSORS above! */
-static struct sensor_template meter_attrs[] = {
-	RO_SENSOR_TEMPLATE(POWER_AVERAGE_NAME, show_power, 0),
-	RO_SENSOR_TEMPLATE("power1_accuracy", show_accuracy, 0),
-	RO_SENSOR_TEMPLATE("power1_average_interval_min", show_val, 0),
-	RO_SENSOR_TEMPLATE("power1_average_interval_max", show_val, 1),
-	RO_SENSOR_TEMPLATE("power1_is_battery", show_val, 5),
-	RW_SENSOR_TEMPLATE(POWER_AVG_INTERVAL_NAME, show_avg_interval,
-			   set_avg_interval, 0),
-	{},
-};
-
-static struct sensor_template misc_cap_attrs[] = {
-	RO_SENSOR_TEMPLATE("power1_cap_min", show_val, 2),
-	RO_SENSOR_TEMPLATE("power1_cap_max", show_val, 3),
-	RO_SENSOR_TEMPLATE("power1_cap_hyst", show_val, 4),
-	RO_SENSOR_TEMPLATE(POWER_ALARM_NAME, show_val, 6),
-	{},
-};
-
-static struct sensor_template ro_cap_attrs[] = {
-	RO_SENSOR_TEMPLATE(POWER_CAP_NAME, show_cap, 0),
-	{},
-};
-
-static struct sensor_template rw_cap_attrs[] = {
-	RW_SENSOR_TEMPLATE(POWER_CAP_NAME, show_cap, set_cap, 0),
-	{},
-};
-
-static struct sensor_template trip_attrs[] = {
-	RW_SENSOR_TEMPLATE("power1_average_min", show_val, set_trip, 7),
-	RW_SENSOR_TEMPLATE("power1_average_max", show_val, set_trip, 8),
-	{},
-};
-
-static struct sensor_template misc_attrs[] = {
-	RO_SENSOR_TEMPLATE("name", show_name, 0),
-	RO_SENSOR_TEMPLATE("power1_model_number", show_str, 0),
-	RO_SENSOR_TEMPLATE("power1_oem_info", show_str, 2),
-	RO_SENSOR_TEMPLATE("power1_serial_number", show_str, 1),
-	{},
-};
-
-#undef RO_SENSOR_TEMPLATE
-#undef RW_SENSOR_TEMPLATE
-
 /* Read power domain data */
 static void remove_domain_devices(struct acpi_power_meter_resource *resource)
 {
@@ -642,107 +292,433 @@ static int read_domain_devices(struct acpi_power_meter_resource *resource)
 	return res;
 }
 
-/* Registration and deregistration */
-static int register_attrs(struct acpi_power_meter_resource *resource,
-			  struct sensor_template *attrs)
+static int set_trip(struct acpi_power_meter_resource *resource, u16 trip_idx,
+		    unsigned long trip)
 {
-	struct device *dev = &resource->acpi_dev->dev;
-	struct sensor_device_attribute *sensors =
-		&resource->sensors[resource->num_sensors];
-	int res = 0;
+	unsigned long trip_bk;
+	int ret;
 
-	while (attrs->label) {
-		sensors->dev_attr.attr.name = attrs->label;
-		sensors->dev_attr.attr.mode = 0444;
-		sensors->dev_attr.show = attrs->show;
-		sensors->index = attrs->index;
+	trip = DIV_ROUND_CLOSEST(trip, 1000);
+	trip_bk = resource->trip[trip_idx];
 
-		if (attrs->set) {
-			sensors->dev_attr.attr.mode |= 0200;
-			sensors->dev_attr.store = attrs->set;
-		}
+	resource->trip[trip_idx] = trip;
+	ret = set_acpi_trip(resource);
+	if (ret) {
+		dev_err(&resource->acpi_dev->dev, "set %s failed.\n",
+			(trip_idx == POWER_METER_TRIP_AVERAGE_MIN_IDX) ?
+			 "power1_average_min" : "power1_average_max");
+		resource->trip[trip_idx] = trip_bk;
+	}
 
-		sysfs_attr_init(&sensors->dev_attr.attr);
-		res = device_create_file(dev, &sensors->dev_attr);
-		if (res) {
-			sensors->dev_attr.attr.name = NULL;
-			goto error;
-		}
-		sensors++;
-		resource->num_sensors++;
-		attrs++;
+	return ret;
+}
+
+static int set_cap(struct acpi_power_meter_resource *resource,
+		   unsigned long cap)
+{
+	union acpi_object arg0 = { ACPI_TYPE_INTEGER };
+	struct acpi_object_list args = { 1, &arg0 };
+	unsigned long long data;
+	acpi_status status;
+
+	cap = DIV_ROUND_CLOSEST(cap, 1000);
+	if (cap > resource->caps.max_cap || cap < resource->caps.min_cap)
+		return -EINVAL;
+
+	arg0.integer.value = cap;
+	status = acpi_evaluate_integer(resource->acpi_dev->handle, "_SHL",
+				       &args, &data);
+	if (ACPI_FAILURE(status)) {
+		acpi_evaluation_failure_warn(resource->acpi_dev->handle, "_SHL",
+					     status);
+		return -EINVAL;
 	}
+	resource->cap = cap;
 
-error:
-	return res;
+	/* _SHL returns 0 on success, nonzero otherwise */
+	if (data)
+		return -EINVAL;
+
+	return 0;
 }
 
-static void remove_attrs(struct acpi_power_meter_resource *resource)
+static int set_avg_interval(struct acpi_power_meter_resource *resource,
+			    unsigned long val)
 {
-	int i;
+	union acpi_object arg0 = { ACPI_TYPE_INTEGER };
+	struct acpi_object_list args = { 1, &arg0 };
+	unsigned long long data;
+	acpi_status status;
 
-	for (i = 0; i < resource->num_sensors; i++) {
-		if (!resource->sensors[i].dev_attr.attr.name)
-			continue;
-		device_remove_file(&resource->acpi_dev->dev,
-				   &resource->sensors[i].dev_attr);
+	if (val > resource->caps.max_avg_interval ||
+	    val < resource->caps.min_avg_interval)
+		return -EINVAL;
+
+	arg0.integer.value = val;
+	status = acpi_evaluate_integer(resource->acpi_dev->handle, "_PAI",
+				       &args, &data);
+	if (ACPI_FAILURE(status)) {
+		acpi_evaluation_failure_warn(resource->acpi_dev->handle, "_PAI",
+					     status);
+		return -EINVAL;
 	}
+	resource->avg_interval = val;
 
-	remove_domain_devices(resource);
+	/* _PAI returns 0 on success, nonzero otherwise */
+	if (data)
+		return -EINVAL;
 
-	resource->num_sensors = 0;
+	return 0;
 }
 
-static int setup_attrs(struct acpi_power_meter_resource *resource)
+static int get_power_alarm_state(struct acpi_power_meter_resource *resource,
+				 long *val)
 {
-	int res = 0;
+	int ret;
 
-	/* _PMD method is optional. */
-	res = read_domain_devices(resource);
-	if (res && res != -ENODEV)
-		return res;
+	ret = update_meter(resource);
+	if (ret)
+		return ret;
 
-	if (resource->caps.flags & POWER_METER_CAN_MEASURE) {
-		res = register_attrs(resource, meter_attrs);
-		if (res)
-			goto error;
+	/* need to update cap if not to support the notification. */
+	if (!(resource->caps.flags & POWER_METER_CAN_NOTIFY)) {
+		ret = update_cap(resource);
+		if (ret)
+			return ret;
+		resource->power_alarm = resource->power > resource->cap;
+		*val = resource->power_alarm;
+	} else {
+		*val = resource->power_alarm || resource->power > resource->cap;
+		resource->power_alarm = resource->power > resource->cap;
 	}
 
-	if (resource->caps.flags & POWER_METER_CAN_CAP) {
-		if (!can_cap_in_hardware()) {
-			dev_warn(&resource->acpi_dev->dev,
-				 "Ignoring unsafe software power cap!\n");
-			goto skip_unsafe_cap;
+	return 0;
+}
+
+static umode_t power_meter_is_visible(const void *data,
+				      enum hwmon_sensor_types type,
+				      u32 attr, int channel)
+{
+	const struct acpi_power_meter_resource *res = data;
+
+	if (type != hwmon_power)
+		return -EINVAL;
+
+	switch (attr) {
+	case hwmon_power_average:
+	case hwmon_power_average_interval_min:
+	case hwmon_power_average_interval_max:
+		if (res->caps.flags & POWER_METER_CAN_MEASURE)
+			return 0444;
+		break;
+	case hwmon_power_average_interval:
+		if (res->caps.flags & POWER_METER_CAN_MEASURE)
+			return 0644;
+		break;
+	case hwmon_power_cap_min:
+	case hwmon_power_cap_max:
+	case hwmon_power_alarm:
+		if (res->caps.flags & POWER_METER_CAN_CAP && can_cap_in_hardware())
+			return 0444;
+		break;
+	case hwmon_power_cap:
+		if (res->caps.flags & POWER_METER_CAN_CAP && can_cap_in_hardware()) {
+			if (res->caps.configurable_cap)
+				return 0644;
+			else
+				return 0444;
 		}
+		break;
+	default:
+		break;
+	}
 
-		if (resource->caps.configurable_cap)
-			res = register_attrs(resource, rw_cap_attrs);
-		else
-			res = register_attrs(resource, ro_cap_attrs);
+	return 0;
+}
 
-		if (res)
-			goto error;
+static int power_meter_read(struct device *dev, enum hwmon_sensor_types type,
+			    u32 attr, int channel, long *val)
+{
+	struct acpi_power_meter_resource *res = dev_get_drvdata(dev);
+	int ret = 0;
 
-		res = register_attrs(resource, misc_cap_attrs);
-		if (res)
-			goto error;
+	if (type != hwmon_power)
+		return -EINVAL;
+
+	guard(mutex)(&res->lock);
+
+	switch (attr) {
+	case hwmon_power_average:
+		ret = update_meter(res);
+		if (ret)
+			return ret;
+		if (res->power == UNKNOWN_POWER)
+			return -ENODATA;
+		*val = res->power * 1000;
+		break;
+	case hwmon_power_average_interval_min:
+		*val = res->caps.min_avg_interval;
+		break;
+	case hwmon_power_average_interval_max:
+		*val = res->caps.max_avg_interval;
+		break;
+	case hwmon_power_average_interval:
+		ret = update_avg_interval(res);
+		if (ret)
+			return ret;
+		*val = (res)->avg_interval;
+		break;
+	case hwmon_power_cap_min:
+		*val = res->caps.min_cap * 1000;
+		break;
+	case hwmon_power_cap_max:
+		*val = res->caps.max_cap * 1000;
+		break;
+	case hwmon_power_alarm:
+		ret = get_power_alarm_state(res, val);
+		if (ret)
+			return ret;
+		break;
+	case hwmon_power_cap:
+		ret = update_cap(res);
+		if (ret)
+			return ret;
+		*val = res->cap * 1000;
+		break;
+	default:
+		break;
 	}
 
-skip_unsafe_cap:
-	if (resource->caps.flags & POWER_METER_CAN_TRIP) {
-		res = register_attrs(resource, trip_attrs);
-		if (res)
-			goto error;
+	return 0;
+}
+
+static int power_meter_write(struct device *dev, enum hwmon_sensor_types type,
+			     u32 attr, int channel, long val)
+{
+	struct acpi_power_meter_resource *res = dev_get_drvdata(dev);
+	int ret;
+
+	if (type != hwmon_power)
+		return -EINVAL;
+
+	guard(mutex)(&res->lock);
+	switch (attr) {
+	case hwmon_power_cap:
+		ret = set_cap(res, val);
+		break;
+	case hwmon_power_average_interval:
+		ret = set_avg_interval(res, val);
+		break;
+	default:
+		ret = -EOPNOTSUPP;
 	}
 
-	res = register_attrs(resource, misc_attrs);
-	if (res)
-		goto error;
+	return ret;
+}
 
-	return res;
-error:
-	remove_attrs(resource);
-	return res;
+static const struct hwmon_channel_info * const power_meter_info[] = {
+	HWMON_CHANNEL_INFO(power, HWMON_P_AVERAGE |
+		HWMON_P_AVERAGE_INTERVAL | HWMON_P_AVERAGE_INTERVAL_MIN |
+		HWMON_P_AVERAGE_INTERVAL_MAX | HWMON_P_CAP | HWMON_P_CAP_MIN |
+		HWMON_P_CAP_MAX | HWMON_P_ALARM),
+	NULL
+};
+
+static const struct hwmon_ops power_meter_ops = {
+	.is_visible = power_meter_is_visible,
+	.read = power_meter_read,
+	.write = power_meter_write,
+};
+
+static const struct hwmon_chip_info power_meter_chip_info = {
+	.ops = &power_meter_ops,
+	.info = power_meter_info,
+};
+
+static ssize_t power1_average_max_store(struct device *dev,
+					struct device_attribute *attr,
+					const char *buf, size_t count)
+{
+	struct acpi_power_meter_resource *res = dev_get_drvdata(dev);
+	unsigned long trip;
+	int ret;
+
+	ret = kstrtoul(buf, 10, &trip);
+	if (ret)
+		return ret;
+
+	mutex_lock(&res->lock);
+	ret = set_trip(res, POWER_METER_TRIP_AVERAGE_MAX_IDX, trip);
+	mutex_unlock(&res->lock);
+
+	return ret == 0 ? count : ret;
+}
+
+static ssize_t power1_average_min_store(struct device *dev,
+					struct device_attribute *attr,
+					const char *buf, size_t count)
+{
+	struct acpi_power_meter_resource *res = dev_get_drvdata(dev);
+	unsigned long trip;
+	int ret;
+
+	ret = kstrtoul(buf, 10, &trip);
+	if (ret)
+		return ret;
+
+	mutex_lock(&res->lock);
+	ret = set_trip(res, POWER_METER_TRIP_AVERAGE_MIN_IDX, trip);
+	mutex_unlock(&res->lock);
+
+	return ret == 0 ? count : ret;
+}
+
+static ssize_t power1_average_min_show(struct device *dev,
+				       struct device_attribute *attr, char *buf)
+{
+	struct acpi_power_meter_resource *res = dev_get_drvdata(dev);
+
+	if (res->trip[POWER_METER_TRIP_AVERAGE_MIN_IDX] < 0)
+		return sysfs_emit(buf, "unknown\n");
+
+	return sysfs_emit(buf, "%lld\n",
+			  res->trip[POWER_METER_TRIP_AVERAGE_MIN_IDX] * 1000);
+}
+
+static ssize_t power1_average_max_show(struct device *dev,
+				       struct device_attribute *attr, char *buf)
+{
+	struct acpi_power_meter_resource *res = dev_get_drvdata(dev);
+
+	if (res->trip[POWER_METER_TRIP_AVERAGE_MAX_IDX] < 0)
+		return sysfs_emit(buf, "unknown\n");
+
+	return sysfs_emit(buf, "%lld\n",
+			  res->trip[POWER_METER_TRIP_AVERAGE_MAX_IDX] * 1000);
+}
+
+static ssize_t power1_cap_hyst_show(struct device *dev,
+			       struct device_attribute *attr, char *buf)
+{
+	struct acpi_power_meter_resource *res = dev_get_drvdata(dev);
+
+	if (res->caps.hysteresis == UNKNOWN_HYSTERESIS)
+		return sysfs_emit(buf, "unknown\n");
+
+	return sysfs_emit(buf, "%llu\n", res->caps.hysteresis * 1000);
+}
+
+static ssize_t power1_accuracy_show(struct device *dev,
+				    struct device_attribute *attr,
+				    char *buf)
+{
+	struct acpi_power_meter_resource *res = dev_get_drvdata(dev);
+
+	return sysfs_emit(buf, "%llu.%llu%%\n",
+			  res->caps.accuracy / 1000, res->caps.accuracy % 1000);
+}
+
+static ssize_t power1_is_battery_show(struct device *dev,
+				      struct device_attribute *attr,
+				      char *buf)
+{
+	struct acpi_power_meter_resource *res = dev_get_drvdata(dev);
+
+	return sysfs_emit(buf, "%u\n",
+			  res->caps.flags & POWER_METER_IS_BATTERY ? 1 : 0);
+}
+
+static ssize_t power1_model_number_show(struct device *dev,
+					struct device_attribute *attr,
+					char *buf)
+{
+	struct acpi_power_meter_resource *res = dev_get_drvdata(dev);
+
+	return sysfs_emit(buf, "%s\n", res->model_number);
+}
+
+static ssize_t power1_oem_info_show(struct device *dev,
+				    struct device_attribute *attr,
+				    char *buf)
+{
+	struct acpi_power_meter_resource *res = dev_get_drvdata(dev);
+
+	return sysfs_emit(buf, "%s\n", res->oem_info);
+}
+
+static ssize_t power1_serial_number_show(struct device *dev,
+					 struct device_attribute *attr,
+					 char *buf)
+{
+	struct acpi_power_meter_resource *res = dev_get_drvdata(dev);
+
+	return sysfs_emit(buf, "%s\n", res->serial_number);
+}
+
+// depend on POWER_METER_CAN_TRIP
+static DEVICE_ATTR_RW(power1_average_max);
+static DEVICE_ATTR_RW(power1_average_min);
+
+// depend on POWER_METER_CAN_CAP
+static DEVICE_ATTR_RO(power1_cap_hyst);
+
+// depend on POWER_METER_CAN_MEASURE
+static DEVICE_ATTR_RO(power1_accuracy);
+static DEVICE_ATTR_RO(power1_is_battery);
+
+static DEVICE_ATTR_RO(power1_model_number);
+static DEVICE_ATTR_RO(power1_oem_info);
+static DEVICE_ATTR_RO(power1_serial_number);
+
+#define EXTRA_FIRST_DYNAMIC_ATTR_ID	3
+#define EXTRA_ATTR_MAX	10
+
+static struct attribute *power_extra_attrs[EXTRA_ATTR_MAX] = {
+	&dev_attr_power1_model_number.attr,
+	&dev_attr_power1_oem_info.attr,
+	&dev_attr_power1_serial_number.attr,
+	NULL
+};
+
+ATTRIBUTE_GROUPS(power_extra);
+
+static void fill_extra_dynamic_attr(struct attribute *attr)
+{
+	int idx = EXTRA_FIRST_DYNAMIC_ATTR_ID;
+
+	for (idx = EXTRA_FIRST_DYNAMIC_ATTR_ID; idx < EXTRA_ATTR_MAX; idx++) {
+		if (!power_extra_attrs[idx])
+			break;
+	}
+
+	power_extra_attrs[idx] = attr;
+}
+
+static void update_power_extra_groups(struct acpi_power_meter_resource *res)
+{
+	int idx;
+
+	for (idx = EXTRA_FIRST_DYNAMIC_ATTR_ID; idx < EXTRA_ATTR_MAX; idx++)
+		power_extra_attrs[idx] = NULL;
+
+	if (res->caps.flags & POWER_METER_CAN_MEASURE) {
+		fill_extra_dynamic_attr(&dev_attr_power1_is_battery.attr);
+		fill_extra_dynamic_attr(&dev_attr_power1_accuracy.attr);
+	}
+
+	if (res->caps.flags & POWER_METER_CAN_CAP) {
+		if (!can_cap_in_hardware()) {
+			dev_warn(&res->acpi_dev->dev,
+				 "Ignoring unsafe software power cap!\n");
+		} else {
+			fill_extra_dynamic_attr(&dev_attr_power1_cap_hyst.attr);
+		}
+	}
+
+	if (res->caps.flags & POWER_METER_CAN_TRIP) {
+		fill_extra_dynamic_attr(&dev_attr_power1_average_max.attr);
+		fill_extra_dynamic_attr(&dev_attr_power1_average_min.attr);
+	}
 }
 
 static void free_capabilities(struct acpi_power_meter_resource *resource)
@@ -852,13 +828,24 @@ static void acpi_power_meter_notify(struct acpi_device *device, u32 event)
 	case METER_NOTIFY_CONFIG:
 		mutex_lock(&resource->lock);
 		free_capabilities(resource);
+		remove_domain_devices(resource);
+		hwmon_device_unregister(resource->hwmon_dev);
 		res = read_capabilities(resource);
-		mutex_unlock(&resource->lock);
 		if (res)
-			break;
-
-		remove_attrs(resource);
-		setup_attrs(resource);
+			dev_err_once(&device->dev, "read capabilities failed.\n");
+		res = read_domain_devices(resource);
+		if (res && res != -ENODEV)
+			dev_err_once(&device->dev, "read domain devices failed.\n");
+		update_power_extra_groups(resource);
+		resource->hwmon_dev =
+			hwmon_device_register_with_info(&device->dev,
+							ACPI_POWER_METER_NAME,
+							resource,
+							&power_meter_chip_info,
+							power_extra_groups);
+		if (IS_ERR(resource->hwmon_dev))
+			dev_err_once(&device->dev, "register hwmon device failed.\n");
+		mutex_unlock(&resource->lock);
 		break;
 	case METER_NOTIFY_TRIP:
 		sysfs_notify(&device->dev.kobj, NULL, POWER_AVERAGE_NAME);
@@ -932,11 +919,17 @@ static int acpi_power_meter_add(struct acpi_device *device)
 	resource->trip[0] = -1;
 	resource->trip[1] = -1;
 
-	res = setup_attrs(resource);
-	if (res)
+	/* _PMD method is optional. */
+	res = read_domain_devices(resource);
+	if (res && res != -ENODEV)
 		goto exit_free_capability;
 
-	resource->hwmon_dev = hwmon_device_register(&device->dev);
+	update_power_extra_groups(resource);
+	resource->hwmon_dev =
+		hwmon_device_register_with_info(&device->dev,
+						ACPI_POWER_METER_NAME, resource,
+						&power_meter_chip_info,
+						power_extra_groups);
 	if (IS_ERR(resource->hwmon_dev)) {
 		res = PTR_ERR(resource->hwmon_dev);
 		goto exit_remove;
@@ -946,7 +939,7 @@ static int acpi_power_meter_add(struct acpi_device *device)
 	goto exit;
 
 exit_remove:
-	remove_attrs(resource);
+	remove_domain_devices(resource);
 exit_free_capability:
 	free_capabilities(resource);
 exit_free:
@@ -965,7 +958,7 @@ static void acpi_power_meter_remove(struct acpi_device *device)
 	resource = acpi_driver_data(device);
 	hwmon_device_unregister(resource->hwmon_dev);
 
-	remove_attrs(resource);
+	remove_domain_devices(resource);
 	free_capabilities(resource);
 
 	kfree(resource);
-- 
2.33.0


